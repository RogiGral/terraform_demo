const AWS = require('aws-sdk');
const stepFunctions = new AWS.StepFunctions();

const USER_REGEXP = /^[a-zA-Z0-9]{32}$/;


exports.handler = async (event) => {

    const user = event.pathParameters.user;

    if (!USER_REGEXP.test(user)) {
        return {
            statusCode: 400,
            body: JSON.stringify('User ID is not valid'),
        };
    }

    const params = {
        stateMachineArn: 'arn:aws:states:eu-central-1:733374962160:stateMachine:state_machine',
        input: JSON.stringify({ user: user }),
    };

    try {
        const data = await stepFunctions.startExecution(params).promise();
        console.log(data);
        return {
            statusCode: 200,
            body: JSON.stringify('Step Function invoked successfully'),
        };
    } catch (err) {
        console.error(err, err.stack);
        return {
            statusCode: 500,
            body: JSON.stringify('Internal server error'),
        };
    }
};