const express = require('express');
const router = express.Router();
const contactController = require('../controllers/contactController'); // Make sure the path is correct

// Add emergency contact (requires user to be authenticated)
router.post('/add', contactController.addContact);

// Get emergency contacts (requires user to be authenticated)
router.get('/get', contactController.getContacts);

module.exports = router;
