const admin = require('../config/firebase').admin;
const db = require('../config/firebase').db;
const twilioClient = require('../config/twilioConfig');
const fs = require('fs');

// Function to send OTP
async function sendOtp(phoneNumber) {
  const otp = Math.floor(100000 + Math.random() * 900000).toString(); // Generate 6-digit OTP

  try {
    await twilioClient.messages.create({
      body: `Your OTP code is ${otp}`,
      from: process.env.TWILIO_PHONE_NUMBER,
      to: phoneNumber,
    });
  } catch (error) {
    console.error('Error sending OTP:', error.message);
    throw error;
  }

  return otp;
}

// Send OTP
exports.sendOtp = async (req, res) => {
  const { phoneNumber } = req.body;
  if (!phoneNumber) return res.status(400).send('Phone number is required');

  try {
    const otp = await sendOtp(phoneNumber);
    await db.collection('otps').doc(phoneNumber).set({ otp, createdAt: new Date() });
    res.status(200).send('OTP sent');
  } catch (error) {
    res.status(500).send('Error sending OTP: ' + error.message);
  }
};

// Verify OTP
exports.verifyOtp = async (req, res) => {
  const { phoneNumber, otp } = req.body;
  if (!phoneNumber || !otp) return res.status(400).send('Phone number and OTP are required');

  try {
    const otpDoc = await db.collection('otps').doc(phoneNumber).get();
    if (!otpDoc.exists) {
      return res.status(404).send('OTP document not found');
    }
    if (otpDoc.data().otp !== otp) {
      return res.status(401).send('Invalid OTP');
    }
    res.status(200).send('OTP verified successfully');
  } catch (error) {
    console.error('Error verifying OTP:', error);
    res.status(500).send('Error verifying OTP: ' + error.message);
  }
};

// Signup function
exports.signup = async (req, res) => {
  const { phoneNumber, emergencyContacts } = req.body;

  if (!phoneNumber || !emergencyContacts || emergencyContacts.length !== 5) {
    return res.status(400).send('Phone number and five emergency contacts are required');
  }

  try {
    // Send OTP
    const otp = await sendOtp(phoneNumber);

    // Save user data and OTP in Firestore
    await db.collection('users').doc(phoneNumber).set({
      phoneNumber,
      emergencyContacts,
      otp,
      sm_pin: null,
    });

    res.status(200).send('OTP sent to your phone number');
  } catch (error) {
    res.status(500).send('Error during signup: ' + error.message);
  }
};

// Finish user registration
exports.finishRegistration = async (req, res) => {
  const { phoneNumber, sm_pin, emergencyContacts } = req.body;

  if (!phoneNumber || !sm_pin || emergencyContacts.length !== 5) {
    return res.status(400).send('Phone number, sm_pin, and five emergency contacts are required');
  }

  try {
    await db.collection('users').doc(phoneNumber).update({
      sm_pin,
      emergencyContacts,
      registrationCompleted: true,
    });
    res.status(200).send('User registration completed');
  } catch (error) {
    res.status(500).send('Error completing registration: ' + error.message);
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

    if (!userDoc.exists || userDoc.data().sm_pin !== sm_pin) {
      return res.status(401).send('Invalid phone number or sm_pin');
    }

    res.status(200).send('Login successful');
  } catch (error) {
    res.status(500).send('Error during login: ' + error.message);
  }
};

// Update location
exports.updateLocation = async (req, res) => {
  const { latitude, longitude } = req.body;

  if (!latitude || !longitude) {
    return res.status(400).send('Latitude and longitude are required');
  }

  try {
    await db.collection('locations').doc(req.user.uid).set({
      latitude,
      longitude,
      updatedAt: new Date(),
    });
    res.status(200).send('Location updated');
  } catch (error) {
    res.status(500).send('Error updating location: ' + error.message);
  }
};

// Get location
exports.getLocation = async (req, res) => {
  try {
    const locationDoc = await db.collection('locations').doc(req.user.uid).get();
    if (!locationDoc.exists) {
      return res.status(404).send('Location not found');
    }
    res.status(200).json(locationDoc.data());
  } catch (error) {
    res.status(500).send('Error fetching location: ' + error.message);
  }
};

// Reset SM Pin
exports.resetPin = async (req, res) => {
  const { phoneNumber, newPin } = req.body;

  if (!phoneNumber || !newPin) {
    return res.status(400).send('Phone number and new pin are required');
  }

  try {
    await db.collection('users').doc(phoneNumber).update({ sm_pin: newPin });
    res.status(200).send('SM pin reset successfully');
  } catch (error) {
    res.status(500).send('Error resetting SM pin: ' + error.message);
  }
};
