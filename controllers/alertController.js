const { db } = require('../config/firebase');
const twilioClient = require('../config/twilioConfig');

exports.createAlert = async (req, res) => {
  const { alertType, message, videoUrl, voiceUrl } = req.body;

  if (!alertType || !message) {
    return res.status(400).send('Alert type and message are required');
  }

  try {
    const alert = { alertType, message, videoUrl, voiceUrl, createdAt: new Date() };
    const userRef = db.collection('users').doc(req.user.uid);
    await userRef.collection('alerts').add(alert);

    res.status(201).json(alert);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

exports.getAlerts = async (req, res) => {
  try {
    const userRef = db.collection('users').doc(req.user.uid);
    const alertsSnapshot = await userRef.collection('alerts').get();
    const alerts = alertsSnapshot.docs.map(doc => doc.data());

    res.json(alerts);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

exports.sendEmergencyAlert = async (req, res) => {
  const { message, videoUrl, voiceUrl, phoneNumbers } = req.body;

  if (!message || !phoneNumbers) {
    return res.status(400).send('Message and phone numbers are required');
  }

  try {
    const promises = phoneNumbers.map(number =>
      twilioClient.messages.create({
        body: message,
        from: process.env.TWILIO_PHONE_NUMBER,
        to: number,
        mediaUrl: videoUrl ? [videoUrl] : voiceUrl ? [voiceUrl] : [],
      })
    );

    await Promise.all(promises);
    res.status(200).send('Emergency alert sent');
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
};

// Trigger SOS
exports.triggerSOS = async (req, res) => {
  const { latitude, longitude, message, phoneNumbers } = req.body;

  if (!latitude || !longitude || !message || !phoneNumbers) {
    return res.status(400).send('Location, message, and phone numbers are required');
  }

  try {
    await this.sendEmergencyAlert(req, res);
    res.status(200).send('SOS triggered');
  } catch (error) {
    res.status(500).send('Error triggering SOS: ' + error.message);
  }
};
