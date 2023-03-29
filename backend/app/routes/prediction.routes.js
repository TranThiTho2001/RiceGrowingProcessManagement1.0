const prediction = require("../controllers/prediction.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", prediction.findAll);

     //find by id
     router.get("/findbyid/:id", prediction.findById);

     //find by RiceCropInformation_id
     router.get("/findbyRiceCropInformation/:RiceCropInformation_id", prediction.findByRiceCropInformationid)

     // // Store 
     router.post("/predictionwithLinearRegreesion/:RiceCropInformation_id", prediction.store);

     // // Store 
     // router.post("/predictionwithRandomForestRegression/:RiceCropInformation_id", prediction.store);

     // // Delete  with id
     // router.delete("/:id", prediction.delete);

     app.use("/api/prediction", router);
};