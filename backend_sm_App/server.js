const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const cors = require('cors');

const app = express();
const server = http.createServer(app); // Define `server`
const io = socketIo(server); // Initialize `socket.io`

app.use(express.json()); 
app.use(cors());

const auth = require('./Controllers/auth.js');
const loc = require('./Controllers/track.js');

app.post('/signin', auth.signin);
app.post('/signup', auth.signup);
app.post('/storeCoordinates', loc.storeCoordinates);
app.post('/update5seconds', loc.update5seconds);

const PORT = 5000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

