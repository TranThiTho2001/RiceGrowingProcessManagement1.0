const backup = require("../controllers/backup.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", backup.findAll);

     //Dowload file
     router.get("/:link", backup.dowload)

     app.use("/api/backup", router);
};