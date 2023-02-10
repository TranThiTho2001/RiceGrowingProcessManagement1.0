const otherActivities = require("../controllers/otherActivities.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();

     // Retrieve all 
     router.get("/", otherActivities.findAll);

     //find by id
     router.get("/:id", otherActivities.find)

     // Store 
     router.post("/", otherActivities.store);

     // Update  with id
     router.put("/:id", otherActivities.update);

     // Delete  with id
     router.delete("/:id", otherActivities.delete);

     app.use("/api/otherActivities", router);
};