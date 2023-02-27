// const image = require("../controllers/image.controller");
const express = require("express");
const upload = require("../middlewares/upload");
const images = require("../controllers/images.controller")
const handle = require("../helpers/promise");

module.exports = (app) => {
    var router = express.Router();
    router.post("/", upload.single('image'),images.store);
    router.get("/",images.findAll);
    router.get("/:id",images.find);
     router.put("/:id", images.update);
     router.delete("/:id", images.delete);
        
    app.use("/api/images", router);

};