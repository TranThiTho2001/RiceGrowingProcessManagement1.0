const employee = require("../controllers/employee.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all todo
     router.get("/", employee.findAll);
console.log("hfeiuowqye")
     // Show form create Todo
     router.get("/create", employee.create);
     router.get("/:id", employee.find)
     // Store Todo
     router.post("/", employee.store);

     // Retrieve a single todo with id
     router.get("/edit/:id", employee.edit);
     // Update a todo with id
     router.put("/:id", employee.update);

     // Delete a todo with id
     router.get("/delete/:id", employee.delete);

     // Delete all todo
     router.delete("/delete", employee.deleteAll);



     app.use("/api/employee", router);

};