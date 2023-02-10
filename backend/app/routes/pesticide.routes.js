const pesticide = require("../controllers/pesticide.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", pesticide.findAll);

     //find by id
     router.get("/:id", pesticide.find)

     // Store 
     router.post("/", pesticide.store);

     // Update  with id
     router.put("/:id", pesticide.update);

     // Delete  with id
     router.delete("/:id", pesticide.delete);

     app.use("/api/pesticide", router);
};