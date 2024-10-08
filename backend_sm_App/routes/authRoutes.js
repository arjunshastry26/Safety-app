const express = require('express');
const authController = require('../controllers/authController');

const router = express.Router();

// Route to send OTP
router.post('/send-otp', authController.sendOtp);

// Route to verify OTP
router.post('/verify-otp', authController.verifyOtp);

// Route for user signup
router.post('/signup', authController.signup);

// Route for user login
router.post('/login', authController.login);

// Route to update live location
router.post('/update-location', authController.updateLiveLocation);

// Route to reset SM pin
router.post('/reset-pin', authController.resetPin);

// Route to get user location
router.post('/get-location', authController.getLocation);

// Route to update emergency contacts
router.post('/update-emergency-contacts', authController.updateEmergencyContacts);

// Route to fetch emergency contacts
router.post('/get-emergency-contacts', authController.getEmergencyContacts);

module.exports = router;
