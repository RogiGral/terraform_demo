const AWS = require('aws-sdk');

exports.handler = async (event) => {

    console.log(JSON.stringify({
        data: {
            statusCode: 400,
            body: {
                code: "dat-com-1",
                message: "Device not found"
            }
        },
        iotPlatform: {
            "originRegion": "eu-west-1",
            "serialNumber": "0x0033005A0004006C011D"
        },
        lambdaInfo: {
            "awsRegion": "eu-west-1",
            "executionEnv": "AWS_Lambda_nodejs18.x",
            "functionName": "iot-data-mgmt-out-sys-eu-prd-getDevice",
            "logStreamName": "2024/02/05/[45]ee64610fe13740fdb26e27cf4764a3ce",
            "memorySize": 512,
            "requestId": "06ae6689-d7fd-4c59-8cfa-91f32899e600",
            "version": 45
        },
        level: "INFO",
        message: "lambda response",
        traceId: "1-65c0c8aa-2524cf6300391787646d4561"
    })
        
    )
    return {
        data: {
            statusCode: 400,
            body: {
                code: "dat-com-1",
                message: "Device not found"
            }
        },
        iotPlatform: {
            "originRegion": "eu-west-1",
            "serialNumber": "0x0033005A0004006C011D"
        },
        lambdaInfo: {
            "awsRegion": "eu-west-1",
            "executionEnv": "AWS_Lambda_nodejs18.x",
            "functionName": "iot-data-mgmt-out-sys-eu-prd-getDevice",
            "logStreamName": "2024/02/05/[45]ee64610fe13740fdb26e27cf4764a3ce",
            "memorySize": 512,
            "requestId": "06ae6689-d7fd-4c59-8cfa-91f32899e600",
            "version": 45
        },
        level: "INFO",
        message: "lambda response",
        traceId: "1-65c0c8aa-2524cf6300391787646d4561"
    };
};