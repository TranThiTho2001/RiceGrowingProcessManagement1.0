const Image = require("../models/image.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    console.log(req.file)
    const image = new Image({
        Image_id: "7",
        Image_link: req.file.path,
        Image_date: "2012-12-03",
        RiceCropInformation_id: "RC00000004",
   });
   // Save Monitor in the database
   Image.create(image, (err, data) => {
        if (err)
             res.send("Không thể lưu hình ảnh.")
        else res.send(data);
   });

};

// Retrieve all Epidemic from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Image.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Image.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy hình ảnh.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Epidemic identified by the id in the request
exports.update = async (req, res) => {
     Image.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy hình ảnh.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Epidemic with the specified id in the request
exports.delete = async (req, res) => {
     Image.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy hình ảnh có mã ${req.params.id}.`)
            } else {
                res.redirect("Lỗi trong quá trình xóa hình ảnh!!");
            }
        } else res.send(data);
    });
};

