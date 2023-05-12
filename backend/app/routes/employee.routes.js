const employee = require("../controllers/employee.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", employee.findAll);
     
     // find by Employee_id
     router.get("/:id", employee.find)

     // look for employees with Role_id = 02 and Role_id = 03
     router.get("/find/findPartial", employee.findPartial)

     // Store 
     router.post("/", employee.store);
     // Update  with id
     router.put("/:id", employee.update);

     // change pasword
     router.put("/change/:id", employee.changePassword);

     // Delete  with id
     router.delete("/:id", employee.delete);

     //Signin
     router.post("/signin", employee.signin);

     app.use("/api/employee", router);
};