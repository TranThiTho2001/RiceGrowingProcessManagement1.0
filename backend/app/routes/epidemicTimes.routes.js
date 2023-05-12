const epidemicTimes = require("../controllers/epidemicTimes.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", epidemicTimes.findAll);

     // find by Epidemic_name
     router.get("/findbyname/:RiceCropInformation_id", epidemicTimes.findByName);
     
     //find by id
     router.get("/:RiceCropInformation_id", epidemicTimes.findbyIdRiceCropInformation)

     // Store 
     router.post("/", epidemicTimes.store);

     // Update  with id
     router.put("/:RiceCropInformation_id/:Epidemic_id/:EpidemicTimes_times", epidemicTimes.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:Epidemic_id/:EpidemicTimes_times", epidemicTimes.delete);

     app.use("/api/epidemicTimes", router);
};