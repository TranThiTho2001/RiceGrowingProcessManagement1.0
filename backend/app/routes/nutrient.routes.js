const nutrient = require("../controllers/nutrient.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", nutrient.findAll);

     //find by id
     router.get("/:id", nutrient.find)

     // Store 
     router.post("/", nutrient.store);

     // Update  with id
     router.put("/:id", nutrient.update);

     // Delete  with id
     router.delete("/:id", nutrient.delete);

     app.use("/api/nutrient", router);
};