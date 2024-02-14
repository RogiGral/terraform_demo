const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient();
  
exports.handler = async (event) => {

  const user = event.user;
  const params = {
    TableName: 'usersTable', 
    Key: {
      userId: user,
    },
  };

  try {
    const data = await docClient.get(params).promise();
    if (!data.Item) {
      throw new Error('User not found');
    }
    return data.Item;
  } catch (err) {
    throw new Error(err);
  }
};