exports.handler = async (event) => {
    return {
        statusCode: 200,
        body: `Hello All, Testing function is running on Node.js ${process.version}!`
    };
};
