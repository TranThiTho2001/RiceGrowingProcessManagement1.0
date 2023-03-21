const activityDetails = require("../controllers/activityDetails.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", activityDetails.findAll); 
         //find by  OtherActivities_id
     router.get("/findbyId/:OtherActivities_id", activityDetails.findbyId);
     router.get("/findbyname/:RiceCropInformation_id", activityDetails.findbyName);

     //find by RiceCropInformationid and OtherActivities_id
     router.get("/:RiceCropInformation_id/:OtherActivities_id", activityDetails.findbyIdRiceCropInformation);



     // Store 
     router.post("/", activityDetails.store);

     // Update  with id
     router.put("/:RiceCropInformation_id/:OtherActivities_id/:ActivityDetails_times", activityDetails.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:OtherActivities_id/:ActivityDetails_times", activityDetails.delete);

     app.use("/api/activityDetails", router);
};