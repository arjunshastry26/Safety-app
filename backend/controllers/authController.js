const admin = require('../config/firebase').admin;
const db = require('../config/firebase').db;
const twilioClient = require('../config/twilioConfig');
const bcrypt = require('bcryptjs');

const OTP_EXPIRATION_TIME = 5 * 60 * 1000; // OTP expiration time set to 5 minutes

let locationUpdateInterval = null; // Variable to hold interval ID

// Function to send OTP
const sendOtp = async (phoneNumber) => {
  const otp = Math.floor(100000 + Math.random() * 900000).toString(); // Generate 6-digit OTP
  const createdAt = new Date();

  try {
    console.log(`Attempting to send OTP to ${phoneNumber}: ${otp}`);

    // Send OTP via Twilio
    await twilioClient.messages.create({
      body: `Your OTP code is ${otp}`,
      from: process.env.TWILIO_PHONE_NUMBER,
      to: phoneNumber,
    });

    console.log(`OTP sent to ${phoneNumber}: ${otp}`);

    // Save OTP to Firestore with timestamp
    await db.collection('otps').doc(phoneNumber).set({
      otp,
      createdAt,
    });

    return otp; // Return the OTP for use in signup
  } catch (error) {
    console.error('Error sending OTP:', error);
    throw new Error('Unable to send OTP. Please try again later.');
  }
};

// Send OTP
exports.sendOtp = async (req, res) => {
  const { phoneNumber } = req.body;

  if (!phoneNumber) {
    return res.status(400).send('Phone number is required');
  }

  try {
    await sendOtp(phoneNumber);
    res.status(200).send('OTP sent');
  } catch (error) {
    console.error('Error sending OTP:', error.message);
    res.status(500).send(error.message); // Return the error message to the client
  }
};

// Verify OTP
exports.verifyOtp = async (req, res) => {
  const { phoneNumber, otp } = req.body;

  if (!phoneNumber || !otp) {
    return res.status(400).send('Phone number and OTP are required');
  }

  try {
    const otpDoc = await db.collection('otps').doc(phoneNumber).get();

    if (!otpDoc.exists) {
      console.error(`No OTP found for phone number: ${phoneNumber}`);
      return res.status(404).send('No OTP found for this phone number');
    }

    const { otp: storedOtp, createdAt } = otpDoc.data();
    const isExpired = new Date() - createdAt.toDate() > OTP_EXPIRATION_TIME;

    console.log(`Created At: ${createdAt.toDate()}, Now: ${new Date()}, Is Expired: ${isExpired}`);

    if (isExpired) {
      return res.status(400).send('OTP has expired');
    }

    console.log(`Stored OTP: ${storedOtp}, User OTP: ${otp}`);
    if (storedOtp !== otp) {
      console.error(`OTP mismatch. Stored: ${storedOtp}, Provided: ${otp}`);
      return res.status(401).send('Invalid OTP');
    }

    // Mark registration as completed after successful OTP verification
    await db.collection('users').doc(phoneNumber).update({
      registrationCompleted: true,
    });

    res.status(200).send('OTP verified successfully');
  } catch (error) {
    console.error('Error verifying OTP:', error.message);
    res.status(500).send('Error verifying OTP. Please try again later.');
  }
};

// New Signup Function (includes SM pin)
exports.signup = async (req, res) => {
  const { phoneNumber, emergencyContacts, sm_pin } = req.body;

  if (!phoneNumber || !sm_pin || !emergencyContacts || emergencyContacts.length !== 5) {
    return res.status(400).send('Phone number, sm_pin, and exactly five emergency contacts are required');
  }

  // Validate emergency contacts format (name and phone number)
  const validContacts = emergencyContacts.every(contact => {
    return contact.name && contact.phoneNumber && typeof contact.phoneNumber === 'string';
  });

  if (!validContacts) {
    return res.status(400).send('Each emergency contact must include a name and a valid phone number');
  }

  try {
    console.log('Preparing to create user document for:', phoneNumber);
    
    // Hash the sm_pin before saving
    const hashedPin = await bcrypt.hash(sm_pin, 10);

    // Save user data and hashed sm_pin in Firestore
    await db.collection('users').doc(phoneNumber).set({
      phoneNumber,
      emergencyContacts,
      sm_pin: hashedPin,
      registrationCompleted: false,
      lastLocation: null, // Initialize last location
    });

    console.log('User document created for:', phoneNumber);

    // Send OTP after saving user data
    await sendOtp(phoneNumber);

    res.status(200).send('OTP sent to your phone number, registration pending OTP verification');
  } catch (error) {
    console.error('Error during signup:', error.message);
    res.status(500).send('Error during signup. Please try again later.');
  }
};

// Login function
exports.login = async (req, res) => {
  const { phoneNumber, sm_pin } = req.body;

  if (!phoneNumber || !sm_pin) {
    return res.status(400).send('Phone number and sm_pin are required');
  }

  try {
    const userDoc = await db.collection('users').doc(phoneNumber).get();

    if (!userDoc.exists) {
      return res.status(401).send('Authentication failed. User not found.');
    }

    // Compare the provided pin with the hashed pin stored in Firestore
    const match = await bcrypt.compare(sm_pin, userDoc.data().sm_pin);
    if (!match) {
      return res.status(401).send('Authentication failed. Invalid SM pin.');
    }

    res.status(200).send('Login successful');
  } catch (error) {
    console.error('Error during login:', error.message);
    res.status(500).send('Error during login. Please try again later.');
  }
};

// Function to update user location
const updateUserLocation = async (phoneNumber) => {
  // Logic to generate random location for testing (replace with actual logic)
  const latitude = (Math.random() * (90 - (-90)) + (-90)).toFixed(6); // Random latitude between -90 and 90
  const longitude = (Math.random() * (180 - (-180)) + (-180)).toFixed(6); // Random longitude between -180 and 180
  const timestamp = new Date();

  const userDocRef = db.collection('users').doc(phoneNumber);

  try {
    // Update the last location
    await userDocRef.update({
      lastLocation: {
        latitude,
        longitude,
        updatedAt: timestamp,
      },
    });
    console.log(`Live location updated for ${phoneNumber}: ${latitude}, ${longitude}`);
  } catch (error) {
    console.error('Error updating live location:', error.message);
  }
};

// Start updating live location every 5 seconds
exports.startLocationUpdates = async (req, res) => {
  const { phoneNumber } = req.body;

  if (!phoneNumber) {
    return res.status(400).send('Phone number is required');
  }

  if (locationUpdateInterval) {
    return res.status(400).send('Location updates are already running');
  }

  locationUpdateInterval = setInterval(() => {
    updateUserLocation(phoneNumber);
  }, 5000); // Update every 5 seconds

  res.status(200).send('Location updates started');
};

// Stop updating live location
exports.stopLocationUpdates = (req, res) => {
  if (!locationUpdateInterval) {
    return res.status(400).send('No location updates to stop');
  }

  clearInterval(locationUpdateInterval);
  locationUpdateInterval = null; // Reset the interval variable
  res.status(200).send('Location updates stopped');
};

// Update user location (live tracking)
exports.updateLiveLocation = async (req, res) => {
  const { phoneNumber, latitude, longitude } = req.body;

  // Validate input
  if (!phoneNumber || !latitude || !longitude) {
    console.log('Validation failed: Missing data');
    return res.status(400).send('Phone number, latitude, and longitude are required');
  }

  const timestamp = new Date();
  console.log('Attempting to update live location data in Firestore');

  const userDocRef = db.collection('users').doc(phoneNumber);

  try {
    // Ensure user document exists
    const userDoc = await userDocRef.get();
    if (!userDoc.exists) {
      throw new Error('User document does not exist');
    }

    // Update the last location
    await userDocRef.update({
      lastLocation: {
        latitude,
        longitude,
        updatedAt: timestamp,
      },
    });

    res.status(200).json({
      message: 'Live location updated successfully',
      phoneNumber,
      latitude,
      longitude,
      updatedAt: timestamp,
    });
  } catch (error) {
    console.error('Error updating live location:', error.message);
    res.status(500).send('Error updating live location: ' + error.message);
  }
};

// Reset SM Pin
exports.resetPin = async (req, res) => {
  const { phoneNumber, newPin } = req.body;

  if (!phoneNumber || !newPin) {
    return res.status(400).send('Phone number and new SM pin are required');
  }

  try {
    const userDoc = await db.collection('users').doc(phoneNumber).get();

    if (!userDoc.exists) {
      return res.status(404).send('User not found');
    }

    // Hash the new pin before saving
    const hashedPin = await bcrypt.hash(newPin, 10);

    await db.collection('users').doc(phoneNumber).update({
      sm_pin: hashedPin,
    });

    res.status(200).send('SM pin reset successfully');
  } catch (error) {
    console.error('Error resetting SM pin:', error.message);
    res.status(500).send('Error resetting SM pin. Please try again later.');
  }
};
