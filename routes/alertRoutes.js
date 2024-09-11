const express = require('express');
const router = express.Router();
const alertController = require('../controllers/alertController');
const { authenticateUser } = require('../middleware/authMiddleware.js'); // Ensure you have this middleware for user authentication

// Create an alert (requires user to be authenticated)
router.post('/create', authenticateUser, alertController.createAlert);

// Get all alerts (requires user to be authenticated)
router.get('/get', authenticateUser, alertController.getAlerts);

// Send emergency alert (requires user to be authenticated)
router.post('/send-emergency-alert', authenticateUser, alertController.sendEmergencyAlert);

// Trigger SOS (requires user to be authenticated)
router.post('/trigger-sos', authenticateUser, alertController.triggerSOS);

module.exports = router;
