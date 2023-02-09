const arableLand = require("../controllers/arableLand.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", arableLand.findAll);

     //find by id
     router.get("/:id", arableLand.find)

     // Store 
     router.post("/", arableLand.store);

     // Update  with id
     router.put("/:id", arableLand.update);

     // Delete  with id
     router.delete("/:id", arableLand.delete);

     app.use("/api/arableLand", router);
};