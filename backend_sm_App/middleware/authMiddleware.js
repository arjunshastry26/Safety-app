const { db } = require('../config/firebase');

// Middleware to authenticate user based on phone number
exports.authenticateUser = async (req, res, next) => {
  const { phoneNumber } = req.body; // Assuming phone number is passed in the request body

  if (!phoneNumber) {
    return res.status(400).send('Phone number is required for authentication');
  }

  try {
    // Check if the provided phone number exists in the 'users' collection in the database
    const userSnapshot = await db.collection('users').where('phoneNumber', '==', phoneNumber).get();

    if (userSnapshot.empty) {
      return res.status(404).send('User with the provided phone number does not exist.');
    }

    // Attach the user data to the request object for further processing
    req.user = userSnapshot.docs[0].data(); // Store user data in req.user

    // Move to the next middleware or route handler
    next();
  } catch (error) {
    console.error('Error in authenticateUser middleware:', error.message);
    res.status(500).send('Error authenticating user: ' + error.message);
  }
};
