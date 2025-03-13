const crypto = require('crypto');

module.exports.storeCoordinates = (req,res) => {
  const {latitude,longitude,timestamp,user} = req.body;

  let result = true;

  //logic to update coordinates to db, if something goes wrong, result = false

  if(result){
    res.status(200).json({status:true, message:`${user} : ${latitude},${longitude} at ${timestamp}`});
  } else {
    res.status(500).json({status:false, message:`error updating live location`});
  }
} 
//
// module.exports.update5seconds = (req, res) => {
//   const { latitude, longitude, timestamp, user } = req.body;
//
//   console.log({status: true, message: `Live location tracking started for ${user}`});
//
//   setInterval(() => {
//     res.status(200).json(`Updating location for ${user}: ${latitude}, ${longitude} at ${timestamp}`);
//
//     //calls storeCoordinates with the same values
//     module.exports.storeCoordinates(
//       { body: { latitude, longitude, timestamp, user } },
//       { status: (code) => ({ json: (data) => console.log(`Response ${code}:`, data) }) }
//     );
//   }, 5000);
// };

const generateUniqueCode = () => {
  return crypto.randomBytes(4).toString('hex');
}

module.exports.createSession = (req, res) => {
  const {user} = req.body;

  if(!user){
    return res.status(400).json({status:false, message:`phoneNumber is required`});
  }
  
  let dbcheck;
  //check if the user exists in db, dbcheck = true if yes, else false

  if(dbcheck){
    const code = generateUniqueCode();
    //db logic to add user to the session
    return res.status(201).json({status:true, message:`${code}`});
  } else {
    return res.status(404).json({status:false, message:`enter a valid phone number`});
  }

  res.status(500).json({status:false, message:`error creating session`});

}

module.exports.joinSession = (req,res) => {
  const {user, code} = req.body;
  
  if(!user || !code){
    return res.status(400).json({status:false, message:`please enter session code and phone Number`});
  }

  let sessionExists;
  //implement db logic to check if session exists, if sessione exists then sessionExists=ture, else false

  if(!sessionExists){
    return res.status(404).json({status:false, message:`this session does not exist, enter a valid session code`});
  }

  //implement db logic to join the session

  res.status(200).json({status:true, message:`you have successfully joined ${code}`});
}


