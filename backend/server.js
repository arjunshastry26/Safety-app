const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const cors = require('cors'); // Ensure CORS is imported

// Initialize express app
const app = express();
app.use(express.json()); // This must come before your routes
app.use(cors()); // Enable CORS

// Import routes
const authRoutes = require('./routes/authRoutes');
const travelCompanionRoutes = require('./routes/travelCompanionRoutes');
const alertRoutes = require('./routes/alertRoutes');

// Use routes
app.use('/api/auth', authRoutes); // Authentication routes
app.use('/api/travel-companion', travelCompanionRoutes); // Travel companion routes
app.use('/api/alert', alertRoutes); // Alert routes

// Create HTTP server and attach socket.io
const server = http.createServer(app);
const io = socketIo(server);

// Socket.io connection
io.on('connection', (socket) => {
  console.log('New client connected');

  // Handle location updates from clients
  socket.on('trackLocation', ({ phoneNumber, latitude, longitude }) => {
    console.log(`Location update for ${phoneNumber}: (${latitude}, ${longitude})`);

    // Broadcast location update to other clients
    socket.broadcast.emit('locationUpdate', { phoneNumber, latitude, longitude });
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

// Start server
const PORT = process.env.PORT || 5000; // Default to 5000 if PORT not set
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`); // Log server status
});
