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
    const uniqueCode = generateUniqueCode();
    await db.collection('travelCompanion').doc(uniqueCode).set({
      users: [req.user.uid, phoneNumber],
      createdAt: new Date(),
    });

    res.status(201).json({ code: uniqueCode });
  } catch (error) {
    res.status(500).send('Error creating travel companion session: ' + error.message);
  }
};

// Join a travel companion session
exports.joinTravelCompanionSession = async (req, res) => {
  const { code } = req.body;

  if (!code) {
    return res.status(400).send('Code is required');
  }

  try {
    const sessionDoc = await db.collection('travelCompanion').doc(code).get();

    if (!sessionDoc.exists) {
      return res.status(404).send('Session not found');
    }

    const session = sessionDoc.data();

    if (!session.users.includes(req.user.uid)) {
      session.users.push(req.user.uid);
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

  try {
    const usersSnapshot = await db.collection('locations').get();
    const users = usersSnapshot.docs.map(doc => doc.data());

    const distances = users.map(user => ({
      uid: user.uid,
      distance: Math.sqrt(Math.pow(user.latitude - latitude, 2) + Math.pow(user.longitude - longitude, 2)),
    }));

    const nearestUser = distances.reduce((prev, curr) => (prev.distance < curr.distance ? prev : curr));
    res.status(200).json(nearestUser);
  } catch (error) {
    res.status(500).send('Error finding nearest user: ' + error.message);
  }
};
