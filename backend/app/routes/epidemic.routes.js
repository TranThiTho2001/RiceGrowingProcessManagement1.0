const epidemic = require("../controllers/epidemic.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", epidemic.findAll);

     //find by id
     router.get("/:id", epidemic.find)

     // Store 
     router.post("/", epidemic.store);

     // Update  with id
     router.put("/:id", epidemic.update);

     // Delete  with id
     router.delete("/:id", epidemic.delete);

     app.use("/api/epidemic", router);
};