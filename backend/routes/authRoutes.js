// alertRoutes.js
const express = require('express');
const { sendSOSAlert, getAlerts } = require('../controllers/alertController'); // Ensure this path is correct
const router = express.Router();

// Route to send SOS alert
router.post('/send', sendSOSAlert);

// Route to get all alerts for the user
router.get('/', getAlerts);

module.exports = router;
