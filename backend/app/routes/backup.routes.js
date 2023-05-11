const backup = require("../controllers/backup.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", backup.findAll);

     router.get("/:link", backup.dowload)

     // Delete  with id
     // router.delete("/:Fertilizer_id/:N?utrient_id", backup.delete);

     app.use("/api/backup", router);
};