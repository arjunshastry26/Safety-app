const express = require('express');
const router = express.Router();

// Correct import of the controller functions
const travelCompanionController = require('../controllers/travelCompanionController');
const { authenticateUser } = require('../middleware/authMiddleware');

// Route Definitions
router.post('/create-session', authenticateUser,travelCompanionController.createTravelCompanionSession);
router.post('/join-session', authenticateUser,travelCompanionController.joinTravelCompanionSession);
router.post('/find-nearest-user', authenticateUser,travelCompanionController.findNearestUser);

// Export the router
module.exports = router;
