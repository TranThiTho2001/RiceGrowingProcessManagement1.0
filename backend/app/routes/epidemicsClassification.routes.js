const epidemicsClassification = require("../controllers/epidemicsClassification.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", epidemicsClassification.findAll);

     //find by id
     router.get("/:id", epidemicsClassification.find)

     // Store 
     router.post("/", epidemicsClassification.store);

     app.use("/api/epidemicsClassification", router);
};