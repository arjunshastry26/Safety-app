const express = require('express');
const app = express();

// Import routes
const authRoutes = require('./routes/authRoutes');
const contactRoutes = require('./routes/contactRoutes');
const travelCompanionRoutes = require('./routes/travelCompanionRoutes');
const alertRoutes = require('./routes/alertRoutes');

// Middleware
app.use(express.json());

// Use routes
app.use('/api/auth', authRoutes);
app.use('/api/contact', contactRoutes);
app.use('/api/travel-companion', travelCompanionRoutes);
app.use('/api/alert', alertRoutes);

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
