require('dotenv').config(); // Ensure this line is at the top

const admin = require('firebase-admin');
const fs = require('fs');

const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_KEY_PATH;

if (!serviceAccountPath) {
  throw new Error('Firebase service account key path is not set in .env file.');
}

if (!fs.existsSync(serviceAccountPath)) {
  throw new Error(`Service account key file not found at path: ${serviceAccountPath}`);
}

admin.initializeApp({
  credential: admin.credential.cert(require(serviceAccountPath)),
});

const db = admin.firestore();

module.exports = { admin, db };
