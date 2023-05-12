const Crop = require("../models/crop.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    const crop = new Crop({
        Crop_id: req.body.Crop_id,
        Crop_name: req.body.Crop_name,
    });

    Crop.create(crop, (err, data) => {
        if (err)
            res.send("Không thể tạo một vụ mùa mới")
        else res.send(data);
    });
};

// Retrieve all Crop from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Crop.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

// find by Crop_id
exports.find = async (req, res) => {
    const id = req.params.id;
    Crop.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy vụ mùa")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Crop identified by the id in the request
exports.update = async (req, res) => {
     Crop.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy vụ mùa")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Crop with the specified id in the request
exports.delete = async (req, res) => {
     Crop.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy vụ mùa có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa vụ mùa!!");
            }
        } else res.send(data);
    });
};

