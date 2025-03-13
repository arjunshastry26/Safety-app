const twilio = require('twilio');
const userNumber = 9876543210 //for demo purposes

const accountSid = 1 //process.env.TWILIO_ACCOUNT_SID;
const authToken = 2 //process.env.TWILIO_AUTH_TOKEN;
const client = twilio(accountSid, authToken);


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

const isValidUrl = (urlString) => {
  try {
    const parsedUrl = new URL(urlString);
    return parsedUrl.protocol === 'http:' || parsedUrl.protocol === 'https:';
  } catch (err) {
    return false;
  }
};

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


