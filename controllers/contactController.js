const { db } = require('../config/firebase');
const admin = require('firebase-admin');

// Add emergency contact function
exports.addContact = async (req, res) => {
  const { name, phone } = req.body;
  try {
    const contact = { name, phone };
    const userRef = db.collection('users').doc(req.user.uid);
    await userRef.update({
      emergencyContacts: admin.firestore.FieldValue.arrayUnion(contact),
    });
    res.status(201).json(contact);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

// Get emergency contacts function
exports.getContacts = async (req, res) => {
  try {
    const userRef = db.collection('users').doc(req.user.uid);
    const userDoc = await userRef.get();
    if (!userDoc.exists) {
      return res.status(404).json({ msg: 'User not found' });
    }
    const user = userDoc.data();
    res.json(user.emergencyContacts);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};
