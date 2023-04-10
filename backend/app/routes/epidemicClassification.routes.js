const epidemicClassification = require("../controllers/epidemicClassification.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", epidemicClassification.findAll);

     //find by id
     router.get("/:id", epidemicClassification.find)

     // Store 
     router.post("/", epidemicClassification.store);

     app.use("/api/epidemicClassification", router);
};