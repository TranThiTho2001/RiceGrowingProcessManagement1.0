const jwt = require("jsonwebtoken");
const config = require("../config");
const { BadRequestError } = require("../helpers/errors");

const verifyToken = (req, res, next) => {
    const employeeHeader = String(req.headers.authorization || "");
    let token = null;

    if (employeeHeader.startsWith("Bearer ")) {
        token = employeeHeader.substring(7, employeeHeader.length);
    }

    if (!token) {
        return next(new BadRequestError(401, "Unauthorized"));
    }

    jwt.verify(token, config.jwt.secret, (error, decoded) => {
        if (error) {
            console.log(error);
            return next(new BadRequestError(401, "Unauthorized"));
        }
        req.Employee_id = decoded.Employee_id;
        return next();
    });
};

module.exports = {
    verifyToken,
};
