const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

module.exports.signin = async (req, res) => {
  const { user, smPIN } = req.body;

  let result;
  //implement logic to check user credentials with db, store true or false in the result var
  try {
    const foundUser = await User.findOne({ user });
    if (foundUser && await bcrypt.compare(smPIN, foundUser.smPIN)) {
      result = true;
      res.status(200).json({ status: true, message: `Successfully signed in ${user}` });
    } else {
      result = false;
      res.status(401).json({ status: false, message: `Invalid user or password` });
    }
  } catch (err) {
    res.status(500).json({ status: false, message: 'Server error', error: err.message });
  }
};

module.exports.signup = async (req, res) => {
  const { user, smPIN } = req.body;

  // logic to write user dets to db
  try {
    const hashedPIN = await bcrypt.hash(smPIN, 10);
    const newUser = new User({ user, smPIN: hashedPIN });
    await newUser.save();
    res.status(200).json({ status: true, message: `Account created successfully, ${user}` });
  } catch (err) {
    res.status(500).json({ status: false, message: 'Error creating account', error: err.message });
  }
};

module.exports.resertPIN = async (req, res) => {
  const { user, smPIN } = req.body;

  let result;
  //logic to change pin in db, let result = true if successful else false
  try {
    const hashedPIN = await bcrypt.hash(smPIN, 10);
    result = await User.updateOne({ user }, { smPIN: hashedPIN });

    if (result.matchedCount > 0) {
      res.status(200).json({ status: true, message: `smPIN successfully reset` });
    } else {
      res.status(404).json({ status: false, message: `User not found` });
    }
  } catch (err) {
    res.status(500).json({ status: false, message: 'Error resetting PIN', error: err.message });
  }
};
