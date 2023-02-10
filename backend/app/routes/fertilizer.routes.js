const fertilizer = require("../controllers/fertilizer.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", fertilizer.findAll);

     //find by id
     router.get("/:id", fertilizer.find)

     // Store 
     router.post("/", fertilizer.store);

     // Update  with id
     router.put("/:id", fertilizer.update);

     // Delete  with id
     router.delete("/:id", fertilizer.delete);

     app.use("/api/fertilizer", router);
};