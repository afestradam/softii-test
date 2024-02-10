exports.success = function (req, res, message, status) {
    const statusCode = status || 200;
    const messageInfo = message || "";
    res.status(status).send({
        error: false,
        status: statusCode,
        body: messageInfo
    });
};

exports.error = function (req, res, message, status) {

    const statusCode = status || 500;
    const messageError = message || "Internal error";

    res.status(status).send({
        error: true,
        status: statusCode,
        body: messageError
    })
}