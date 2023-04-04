const province = require("../controllers/province.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", province.findAll);

     //find by id
     router.get("/:id", province.find)

     // Store 
     router.post("/", province.store);

     // Update  with id
     router.put("/:id", province.update);

     // Delete  with id
     router.delete("/:id", province.delete);

     app.use("/api/province", router);
};