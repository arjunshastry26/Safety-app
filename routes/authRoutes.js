const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Send OTP
router.post('/send-otp', authController.sendOtp);

// Verify OTP
router.post('/verify-otp', authController.verifyOtp);

// Signup
router.post('/signup', authController.signup);

// Finish registration
router.post('/finish-registration', authController.finishRegistration);

// Login
router.post('/login', authController.login);

// Update user location (requires user to be authenticated)
router.post('/update-location', authController.updateLocation);

// Get current location (requires user to be authenticated)
router.get('/get-location', authController.getLocation);

// Reset SM Pin
router.post('/reset-pin', authController.resetPin);

module.exports = router;
