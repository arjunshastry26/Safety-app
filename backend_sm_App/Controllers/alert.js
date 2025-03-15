const twilio = require('twilio');
const userNumber = 9876543210 //for demo purposes

const accountSid = 1 //process.env.TWILIO_ACCOUNT_SID;
const authToken = 2 //process.env.TWILIO_AUTH_TOKEN;
//const client = twilio(accountSid, authToken);


module.exports.addContacts = (req,res) => {
  const {user,contact} = req.body;

  if(!user){
    return res.status(404).json({status:false, message:`enter valid phone Number`});
  }
  
  let dbwrite = true;
  // db logic to write to db, if some error occurs, set dbwrite to false
  
  if(!dbwrite){
    return res.status(500).json({status:false, message:`An error occured while saving the contact`});
  }

  res.status(200).json({status:true, message:`contact ${contact} stored successfully`});
}

// const isValidUrl = (urlString) => {
//   try {
//     const parsedUrl = new URL(urlString);
//     return parsedUrl.protocol === 'http:' || parsedUrl.protocol === 'https:';
//   } catch (err) {
//     return false;
//   }
// };

module.exports.sendSOS = async (req,res) => {
  const {latitude, longitude, msg, videoUrl, voiceUrl, user} = req.body;

  if (!latitude || !longitude || !message ) {
    return res.status(400).send('Location and message parameter are required');
  }

  let recipientsArray =  [100, 102, 101, 181, 1098]
  
  const alert = {
    alertType: 'SOS',
    msg,
    videoUrl,
    voiceUrl,
    createdAt: new Date(),
    location: {latitude,longitude},
    };

  // db logic to add user defined contcts (if any exist) to the recipientsArray

  //helper func to send alerts
  async function createMessage(receiver) {
    const message = await client.messages.create({
      body: JSON.stringify(alert),
      from: userNumber,
      to: receiver,
  });
}

try{
  await Promise.all(recipientsArray.map(createMessage));
  // db logic to store the alert
  res.status(200).json({status:true, message:`alert sent successfully`});
} catch (error) {
  res.status(500).json({status:false, message:`error sending alert: ${error}`});
}

}

const safetyTips = [
  "Always use official ride-hailing apps or registered taxis to avoid scams",
  " Before entering a cab, match the license plate and driver details with your app.",
  "Sit in the back seat when using ride-hailing services for added safety.",
  "Share your live location with a trusted friend while using public transport or taxis.",
  "Avoid traveling alone at night, especially in unfamiliar or remote areas.",
  "Plan your route in advance to avoid getting lost or taken on longer routes.",
  "Check for emergency exits when boarding buses, trains, or ferries.",
  " If using a rental car, inspect it first and ensure it has a full tank and emergency tools.",
  " Be cautious of 'helpful strangers' offering unsolicited assistance at transport hubs.",
  "Avoid unlicensed airport taxis—use official taxi stands or app-based rides.",
  "If lost, enter a shop or hotel to ask for directions instead of asking strangers on the street.",
  " If an unknown vehicle follows you, head to the nearest crowded place and call for help."
]

// function for retuning a random tip from the safetyTips array
const sendSafetyTip = () => {
  let index = Math.floor(Math.random() * safetyTips.length);
  return safetyTips[index];
}

module.exports = {sendSafetyTip};


