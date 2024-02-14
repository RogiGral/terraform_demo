const AWS = require('aws-sdk');
const s3 = new AWS.S3();

exports.handler = async (event) => {
    const folderName = event.user;
    const params = {
        Bucket: 'user-logs-s3-bucket-dev', 
        Prefix: folderName
    };

    try {
        const data = await s3.listObjectsV2(params).promise();
        const files = data.Contents.map(item => {
            const splitName = item.Key.split('/');
            if(splitName[1].length === 0){
                throw new Error('No files found');
            }
            console.log(splitName.length)
            return splitName.length > 1;
        });
        const numberOfFiles = files.length;
        return {numberOfFiles: numberOfFiles};

    }catch (error) {
        throw new Error(error);
    }
};