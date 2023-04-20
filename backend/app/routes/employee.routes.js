const employee = require("../controllers/employee.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", employee.findAll);
     
     router.get("/:id", employee.find)

     router.get("/find/findPartial", employee.findPartial)

     // Store 
     router.post("/", employee.store);
     // Update  with id
     router.put("/:id", employee.update);

     // change pasword
     router.put("/change/:id", employee.changePassword);

     // Delete  with id
     router.delete("/:id", employee.delete);


     router.post("/signin", employee.signin);

     app.use("/api/employee", router);
};