const riceCropInformation = require("../controllers/riceCropInformation.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", riceCropInformation.findAll);

     //find by id
     router.get("/:id", riceCropInformation.find);

     //find by employee and name ricecrop
     router.get("/:name/:Employee_id", riceCropInformation.findbyEmployeeAndRiceCrop)


     // Store 
     router.post("/", riceCropInformation.store);

     // Update  with id
     router.put("/:id", riceCropInformation.update);

     // Delete  with id
     router.delete("/:id", riceCropInformation.delete);

     app.use("/api/riceCropInformation", router);
};