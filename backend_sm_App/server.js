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
const alr = require('./Controllers/alert.js');

app.post('/signin', auth.signin);
app.post('/signup', auth.signup);

app.post('/storeCoordinates', loc.storeCoordinates);
app.post('/joinSession', loc.joinSession);
app.post('/createSession', loc.createSession);

app.get('/sendSafetyTip', (req,res) => {
  res.json({status:true, message:alr.sendSafetyTip()});
})

const PORT = 5000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

