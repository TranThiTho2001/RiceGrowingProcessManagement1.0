const fertilizerTimes = require("../controllers/fertilizerTimes.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", fertilizerTimes.findAll);

     //find by id
     router.get("/:RiceCropInformation_id", fertilizerTimes.findbyIdRiceCropInformation)

     // Store 
     router.post("/", fertilizerTimes.store);

     // Update  with id
     router.put("/:RiceCropInformation_id/:Fertilizer_id/:FertilizerTimes_times", fertilizerTimes.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:Fertilizer_id/:FertilizerTimes_times", fertilizerTimes.delete);

     app.use("/api/fertilizerTimes", router);
};