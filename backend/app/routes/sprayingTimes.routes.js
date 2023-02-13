const sprayingTimes = require("../controllers/sprayingTimes.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", sprayingTimes.findAll);

     //find by id
     router.get("/:RiceCropInformation_id", sprayingTimes.findbyIdRiceCropInformation)

     // Store 
     router.post("/", sprayingTimes.store);

     // Update  with id
     router.put("/:RiceCropInformation_id/:Pesticide_id/:SprayingTimes_times", sprayingTimes.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:Pesticide_id/:SprayingTimes_times", sprayingTimes.delete);

     app.use("/api/sprayingTimes", router);
};