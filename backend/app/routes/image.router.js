// const image = require("../controllers/image.controller");
const express = require("express");
const upload = require("../middlewares/upload");
const image = require("../controllers/image.controller")
const handle = require("../helpers/promise");

module.exports = (app) => {
    var router = express.Router();
''

    router.post("/", upload.single('image'),image.store);
    router.get("/",image.findAll);
    router.get("/:id",image.find);
     // Update  with id
     router.put("/:id", image.update);
     router.delete("/:id", image.delete);
        
    app.use("/api/image", router);

};