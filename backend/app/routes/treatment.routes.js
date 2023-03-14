const treatment = require("../controllers/treatment.controller");
const express = require("express");

module.exports = (app) => {
     var router = express.Router();
 
     router.get("/", treatment.findAll);

     router.get("/findbyPesticideName/", treatment.findbyPesticideName);

     router.get("/findbyPesticideId/:Pesticide_id", treatment.findbyPesticideid);

     router.get("/findbyEpidemicId/:Epidemic_id", treatment.findbyEidemicid);
     
     router.get("/findbyEpidemicName/", treatment.findbyEidemicName);

     router.post("/", treatment.store);

     router.put("/:Pesticide_id/:Epidemic_id", treatment.update);

     router.delete("/:Pesticide_id/:Epidemic_id", treatment.delete);

     app.use("/api/treatment", router);
};