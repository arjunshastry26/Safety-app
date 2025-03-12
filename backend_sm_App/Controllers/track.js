
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
