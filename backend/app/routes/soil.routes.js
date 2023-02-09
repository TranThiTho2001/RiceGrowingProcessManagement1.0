const soil = require("../controllers/soil.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", soil.findAll);

     //find by id
     router.get("/:id", soil.find)

     // Store 
     router.post("/", soil.store);

     // Update  with id
     router.put("/:id", soil.update);

     // Delete  with id
     router.delete("/:id", soil.delete);

     app.use("/api/soil", router);
};