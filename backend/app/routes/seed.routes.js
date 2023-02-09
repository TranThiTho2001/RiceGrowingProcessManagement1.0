const seed = require("../controllers/seed.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", seed.findAll);

     //find by id
     router.get("/:id", seed.find)

     // Store 
     router.post("/", seed.store);

     // Update  with id
     router.put("/:id", seed.update);

     // Delete  with id
     router.delete("/delete/:id", seed.delete);

     app.use("/api/seed", router);
};