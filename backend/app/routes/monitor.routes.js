const monitor = require("../controllers/monitor.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", monitor.findAll);

     
     router.get("/findbyname/:RiceCropInformation_id", monitor.findbyName);

     //find by id
     router.get("/:id", monitor.findbyIdRiceCropInformation)

     // Store 
     router.post("/", monitor.store);

     // Update  with id
     router.put("/:id", monitor.update);

     // Delete  with id
     router.delete("/:RiceCropInformation_id/:Employee_id", monitor.delete);

     app.use("/api/monitor", router);
};