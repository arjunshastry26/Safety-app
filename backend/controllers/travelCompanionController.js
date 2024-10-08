const { db } = require('../config/firebase');
const crypto = require('crypto');

// Generate a unique code
function generateUniqueCode() {
  return crypto.randomBytes(4).toString('hex');
}

// Create a travel companion session
exports.createTravelCompanionSession = async (req, res) => {
  const { phoneNumber } = req.body;

  if (!phoneNumber) {
    return res.status(400).send('Phone number is required');
  }

  try {
    // Check if the provided phone number exists in the database
    const userSnapshot = await db.collection('users').where('phoneNumber', '==', phoneNumber).get();

    if (userSnapshot.empty) {
      return res.status(404).send('User with the provided phone number does not exist.');
    }

    // Generate a unique code for the session
    const uniqueCode = generateUniqueCode();

    // Create the session
    await db.collection('travelCompanion').doc(uniqueCode).set({
      users: [phoneNumber],
      createdAt: new Date(),
    });

    // Construct the link to join the travel companion session
    const createLink = `https://yourapp.com/travel-companion/${uniqueCode}`;
    
    // Send the link as a response
    res.status(201).json({ link: createLink });
  } catch (error) {
    console.error('Error creating travel companion session:', error); // Log error for debugging
    res.status(500).send('Error creating travel companion session: ' + error.message);
  }
};

// Join a travel companion session
exports.joinTravelCompanionSession = async (req, res) => {
  const { code, phoneNumber } = req.body;

  if (!code) {
    return res.status(400).send('Code is required');
  }

  if (!phoneNumber) {
    return res.status(400).send('Phone number is required');
  }

  try {
    const sessionDoc = await db.collection('travelCompanion').doc(code).get();

    if (!sessionDoc.exists) {
      return res.status(404).send('Session not found');
    }

    const session = sessionDoc.data();

    // Check if the user is already part of the session
    if (!session.users.includes(phoneNumber)) {
      session.users.push(phoneNumber);
      await db.collection('travelCompanion').doc(code).update({ users: session.users });
    }

    res.status(200).send('Joined session successfully');
  } catch (error) {
    res.status(500).send('Error joining travel companion session: ' + error.message);
  }
};

// Find nearest app user to the person in danger
exports.findNearestUser = async (req, res) => {
  const { latitude, longitude } = req.body;

  // Check if latitude and longitude are provided
  if (latitude == null || longitude == null) {
    return res.status(400).send('Latitude and longitude are required');
  }

  try {
    const usersSnapshot = await db.collection('locations').get();
    const users = usersSnapshot.docs.map(doc => doc.data());

    const distances = users.map(user => ({
      phoneNumber: user.phoneNumber,
      distance: calculateDistance(user.latitude, user.longitude, latitude, longitude),
    }));

    const nearestUser = distances.reduce((prev, curr) => (prev.distance < curr.distance ? prev : curr));

    // Notify both users (you would implement the notification system here)
    notifyUsers(nearestUser.phoneNumber, phoneNumber); // Update this line as needed

    res.status(200).json(nearestUser);
  } catch (error) {
    res.status(500).send('Error finding nearest user: ' + error.message);
  }
};

// Function to notify users (stub for implementation)
function notifyUsers(nearestPhoneNumber, inDangerPhoneNumber) {
  // Implement WebSocket or other notification logic here
  console.log(`Notifying user with phone number ${nearestPhoneNumber} that user with phone number ${inDangerPhoneNumber} needs help.`);
}
