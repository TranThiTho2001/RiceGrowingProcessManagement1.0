const Soil = require("../models/soil.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    console.log(req.body.characteristic,req.body.supplier )
    const soil = new Soil({
        id: req.body.id,
        name: req.body.name,
        characteristic: req.body.characteristic,
        supplier: req.body.supplier,
    });
    // Save Soil in the database
    Soil.create(soil, (err, data) => {
        if (err)
            res.send("Không thể tạo một loại đất mới")
        else res.send(data);
    });
};

// Retrieve all Soil from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Soil.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Soil.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy loại đất")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Soil identified by the id in the request
exports.update = async (req, res) => {
     Soil.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy loại đất")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Soil with the specified id in the request
exports.delete = async (req, res) => {
     Soil.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy loại đất có mã ${req.params.id}`)
            } else {
                res.redirect("Lỗi trong quá trình xóa loại đất!!");
            }
        } else res.send(data);
    });
};

