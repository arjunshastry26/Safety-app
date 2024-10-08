const { db } = require('../config/firebase');
const twilioClient = require('../config/twilioConfig');
const rateLimit = require('express-rate-limit');
const admin = require('firebase-admin');

// Predefined local authorities numbers in India
const localAuthoritiesNumbers = {
  police: '100',
  ambulance: '102',
  fire: '101',
  womenSafety: '181',
  childProtection: '1098',
};

// Rate limiting middleware for SOS alerts
const sosAlertLimiter = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  max: 3, // limit each IP to 3 requests per windowMs
  message: 'Too many SOS alerts sent from this IP, please try again later.',
});

// Function to validate media URLs
const isValidUrl = (urlString) => {
  try {
    const parsedUrl = new URL(urlString);
    return parsedUrl.protocol === 'http:' || parsedUrl.protocol === 'https:';
  } catch (err) {
    return false;
  }
};

// Send SOS alert with location
exports.sendSOSAlert = async (req, res) => {
  const { latitude, longitude, message, videoUrl, voiceUrl, sendTo } = req.body;

  // Validate required fields
  if (!latitude || !longitude || !message || !sendTo) {
    return res.status(400).send('Location, message, and sendTo parameter are required');
  }

  // Validate sendTo parameter
  if (sendTo !== 'contacts' && sendTo !== 'authorities') {
    return res.status(400).send('sendTo must be either "contacts" or "authorities"');
  }

  // Validate media URLs
  if (videoUrl && !isValidUrl(videoUrl)) {
    return res.status(400).send('Invalid video URL');
  }
  if (voiceUrl && !isValidUrl(voiceUrl)) {
    return res.status(400).send('Invalid voice URL');
  }

  try {
    // Create alert object
    const alert = {
      alertType: 'SOS',
      message,
      videoUrl,
      voiceUrl,
      createdAt: new Date(),
      location: {
        latitude,
        longitude,
      },
      recipients: [],
    };

    // Save the alert in the user's alerts collection
    const userRef = db.collection('users').doc(req.user.uid);
    const alertRef = await userRef.collection('alerts').add(alert);

    // Determine the recipients based on sendTo parameter
    let recipients = [];
    if (sendTo === 'contacts') {
      recipients = req.user.contacts; // Assuming contacts are stored in the user document
    } else if (sendTo === 'authorities') {
      recipients = Object.values(localAuthoritiesNumbers);
    }

    // Send emergency alerts via Twilio and store recipient info
    const promises = recipients.map(async (number) => {
      try {
        const messageDetails = await twilioClient.messages.create({
          body: message,
          from: process.env.TWILIO_PHONE_NUMBER,
          to: number,
          mediaUrl: videoUrl ? [videoUrl] : voiceUrl ? [voiceUrl] : [],
        });

        // Log the alert details
        console.log(`SOS alert sent to ${number}: ${messageDetails.status}`);

        // Store recipient information in the alert document
        await alertRef.update({
          recipients: admin.firestore.FieldValue.arrayUnion({
            number,
            status: messageDetails.status,
            dateSent: new Date(),
          }),
        });
      } catch (twilioError) {
        console.error(`Error sending alert to ${number}: ${twilioError.message}`);
        await alertRef.update({
          recipients: admin.firestore.FieldValue.arrayUnion({
            number,
            status: 'failed',
            error: twilioError.message,
            dateSent: new Date(),
          }),
        });
      }
    });

    await Promise.all(promises);

    // Respond with success message
    res.status(200).send('SOS alert sent successfully');
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Error sending SOS alert: ' + err.message);
  }
};

// Get all alerts for the user
exports.getAlerts = async (req, res) => {
  try {
    const userRef = db.collection('users').doc(req.user.uid);
    const alertsSnapshot = await userRef.collection('alerts').get();
    const alerts = alertsSnapshot.docs.map(doc => doc.data());

    res.status(200).json(alerts);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Error fetching alerts: ' + err.message);
  }
};
