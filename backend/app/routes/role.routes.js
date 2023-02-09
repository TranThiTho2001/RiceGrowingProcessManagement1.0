const role = require("../controllers/role.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", role.findAll);

     //find by id
     router.get("/:id", role.find)

     // Store 
     router.post("/", role.store);

     // Update  with id
     router.put("/:id", role.update);

     // Delete  with id
     router.delete("/:id", role.delete);

     app.use("/api/role", router);
};