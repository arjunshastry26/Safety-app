//const bcrypt = require('bcryptjs'); use if hashing

module.exports.signin = (req, res) => {
  const {user,smPIN} = req.body;

  let result;
  //implement logic to check user credentials with db, store true or false in the result var

  if(result){
    res.status(200).json({status: true, message:`successfully signed in ${user}`});
  } else {
    res.status(401).json({status:false, message:`Invalid user or password`});
  }
}

module.exports.signup = (req,res) => {
  const {user,smPIN} = req.body;

  // logic to write user dets to db

  res.status(200).json({status:true, message:`account created succesffuly,${user}, with smPIN:${smPIN}`});
}

module.exports.resertPIN = (req,res) => {
  const {user,smPIN} = req.body;

  let result;
  //logic to change pin in db, let result = true is successfull else false
  if(result){
    res.status(200).json({status:true, message:`smPIN successfully reset`});
  } else {
    res.status(404).json({status:false, message:`user not found`});
  }
}
