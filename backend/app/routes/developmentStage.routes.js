const developmentStage = require("../controllers/developmentStage.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", developmentStage.findAll);

     //find by id
     router.get("/:id", developmentStage.find)

     // Store 
     router.post("/", developmentStage.store);

     // Update  with id
     router.put("/:id", developmentStage.update);

     // Delete  with id
     router.delete("/:id", developmentStage.delete);

     app.use("/api/developmentStage", router);
};