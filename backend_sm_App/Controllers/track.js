const { MongoClient } = require('mongodb');
const crypto = require('crypto');

const uri = 'mongodb+srv://pes2202401414:Doremon26@cluster0.2ivxn.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
const client = new MongoClient(uri);
const dbName = 'SafetyMitra';
const coordinatesCollection = 'coordinates';
const sessionsCollection = 'sessions';

// logic to update coordinates to db, if something goes wrong, result = false
module.exports.storeCoordinates = async (req, res) => {
  const { latitude, longitude, timestamp, user } = req.body;

  try {
    await client.connect();
    const db = client.db(dbName);
    const result = await db.collection(coordinatesCollection).insertOne({ user, latitude, longitude, timestamp });

    if (result.acknowledged) {
      res.status(200).json({ status: true, message: `${user} : ${latitude},${longitude} at ${timestamp}` });
    } else {
      res.status(500).json({ status: false, message: `error updating live location` });
    }
  } catch (error) {
    res.status(500).json({ status: false, message: `error updating live location` });
  } finally {
    await client.close();
  }
};

const generateUniqueCode = () => {
  return crypto.randomBytes(4).toString('hex');
};

// check if the user exists in db, dbcheck = true if yes, else false
module.exports.createSession = async (req, res) => {
  const { user } = req.body;

  if (!user) {
    return res.status(400).json({ status: false, message: `phoneNumber is required` });
  }

  try {
    await client.connect();
    const db = client.db(dbName);
    const dbcheck = await db.collection(sessionsCollection).findOne({ users: user });

    if (dbcheck) {
      const code = generateUniqueCode();
      // db logic to add user to the session
      await db.collection(sessionsCollection).insertOne({ code, users: [user] });
      return res.status(201).json({ status: true, message: `${code}` });
    } else {
      return res.status(404).json({ status: false, message: `enter a valid phone number` });
    }
  } catch (error) {
    res.status(500).json({ status: false, message: `error creating session` });
  } finally {
    await client.close();
  }
};

// implement db logic to check if session exists, if session exists then sessionExists=true, else false
module.exports.joinSession = async (req, res) => {
  const { user, code } = req.body;

  if (!user || !code) {
    return res.status(400).json({ status: false, message: `please enter session code and phone Number` });
  }

  try {
    await client.connect();
    const db = client.db(dbName);
    const sessionExists = await db.collection(sessionsCollection).findOne({ code });

    if (!sessionExists) {
      return res.status(404).json({ status: false, message: `this session does not exist, enter a valid session code` });
    }

    // implement db logic to join the session
    await db.collection(sessionsCollection).updateOne(
      { code },
      { $addToSet: { users: user } }
    );

    res.status(200).json({ status: true, message: `you have successfully joined ${code}` });
  } catch (error) {
    res.status(500).json({ status: false, message: `error joining session` });
  } finally {
    await client.close();
  }
};
