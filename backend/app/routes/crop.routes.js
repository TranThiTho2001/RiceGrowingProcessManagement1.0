const crop = require("../controllers/crop.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", crop.findAll);

     //find by id
     router.get("/:id", crop.find)

     // Store 
     router.post("/", crop.store);

     // Update  with id
     router.put("/:id", crop.update);

     // Delete  with id
     router.delete("/:id", crop.delete);

     app.use("/api/crop", router);
};