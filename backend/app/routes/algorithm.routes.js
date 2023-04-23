const algorithm = require("../controllers/algorithm.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", algorithm.findAll);

     //find by id
     router.get("/:id", algorithm.find)

     // Store 
     router.post("/", algorithm.store);

     // Update  with id
     router.put("/:id", algorithm.update);

     // Delete  with id
     router.delete("/:id", algorithm.delete);

     app.use("/api/algorithm", router);
};