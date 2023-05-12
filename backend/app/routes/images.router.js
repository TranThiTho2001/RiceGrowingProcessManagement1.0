// const image = require("../controllers/image.controller");
const express = require("express");
const upload = require("../middlewares/upload");
const images = require("../controllers/images.controller")
const handle = require("../helpers/promise");

module.exports = (app) => {
    var router = express.Router();

    // save image
    router.post("/", upload.single('image'),images.store);

    // get all
    router.get("/",images.findAll);

    //find by Images_id
    router.get("/:id",images.find);
        
    app.use("/api/images", router);

};