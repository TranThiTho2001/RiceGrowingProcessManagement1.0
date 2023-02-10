const activityDetails = require("../controllers/activityDetails.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", activityDetails.findAll);

     //find by id
     router.get("/:RiceCropInformation_id", activityDetails.findbyIdRiceCropInformation)

     // Store 
     router.post("/", activityDetails.store);

     // Update  with id
     router.put("/:RiceCropInformation_id/:OtherActivities_id/:times", activityDetails.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:OtherActivities_id/:times", activityDetails.delete);

     app.use("/api/activityDetails", router);
};