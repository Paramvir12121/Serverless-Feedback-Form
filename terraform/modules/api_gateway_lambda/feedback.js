exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify('Thank You! Your feedback was recieved')
    }
    return response;
}