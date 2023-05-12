const activityDetails = require("../controllers/activityDetails.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", activityDetails.findAll);

    // find by OtherActivities_id (Activity id)
     router.get("/findbyId/:OtherActivities_id", activityDetails.findbyId);

     // find by name
     router.get("/findbyName/:OtherActivities_name", activityDetails.findbyName);

     // find by RiceCropInformation_id and activity name
     router.get("/findbynameandidricecrop/:RiceCropInformation_id", activityDetails.findbyNameAndIdRiceCrop);

     //find by RiceCropInformationid and OtherActivities_id
     router.get("/:RiceCropInformation_id/:OtherActivities_id", activityDetails.findbyIdRiceCropInformation);

     // find by RiceCropInformation_id
     router.get("/:RiceCropInformation_id/:OtherActivities_id", activityDetails.findbyIdRiceCropInformation);

     // Store 
     router.post("/", activityDetails.store);

     // Update  with id
     router.put("/:RiceCropInformation_id/:OtherActivities_id/:ActivityDetails_times", activityDetails.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:OtherActivities_id/:ActivityDetails_times", activityDetails.delete);

     
     app.use("/api/activityDetails", router);
};