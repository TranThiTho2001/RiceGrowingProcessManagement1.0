const contain = require("../controllers/contain.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", contain.findAll);

     //find by id
     router.get("/getbyFertilizerId/:Fertilizer_id", contain.findbyFertilizerId)

     //find by id
     router.get("/getbyNutrientId/:Nutrient_id", contain.findbyNutrientID);

     //find by id
     router.get("/getbyFertilizerAndNutrient/:Fertilizer_id/:Nutrient_id", contain.findbyFertilizerAndNutrient)

     // Store 
     router.post("/", contain.store);

     // Update  with id
     router.put("/:Fertilizer_id/:Nutrient_id", contain.update);

     // Delete  with id
     router.delete("/:Fertilizer_id/:Nutrient_id", contain.delete);

     app.use("/api/contain", router);
};