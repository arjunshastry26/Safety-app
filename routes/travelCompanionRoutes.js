const express = require('express');
const router = express.Router();
const travelCompanionController = require('../controllers/travelCompanionController');
const { authenticateUser } = require('../middleware/authMiddleware'); // Ensure you have this middleware for user authentication

// Create a travel companion session (requires user to be authenticated)
router.post('/create-session', authenticateUser, travelCompanionController.createTravelCompanionSession);

// Join a travel companion session (requires user to be authenticated)
router.post('/join-session', authenticateUser, travelCompanionController.joinTravelCompanionSession);

// Find nearest app user to the person in danger (requires user to be authenticated)
router.post('/find-nearest-user', authenticateUser, travelCompanionController.findNearestUser);

module.exports = router;
