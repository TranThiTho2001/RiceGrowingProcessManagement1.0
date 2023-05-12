// const image = require("../controllers/image.controller");
const express = require("express");
const upload = require("../middlewares/upload");
const image = require("../controllers/image.controller")
const handle = require("../helpers/promise");

module.exports = (app) => {
    var router = express.Router();

    //save image
    router.post("/", upload.single('image'),image.store);

    // find by id
    router.get("/:id",image.find);
        
    app.use("/api/image", router);
};