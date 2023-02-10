const Seed = require("../models/seed.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const seed = new Seed({
        id: req.body.id,
        name: req.body.name,
        characteristic: req.body.characteristic,
        supplier: req.body.supplier,
    });
    // Save Seed in the database
    Seed.create(seed, (err, data) => {
        if (err)
            res.send("Không thể tạo một giống lúa mới")
        else res.send(data);
    });
};

// Retrieve all Seed from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Seed.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Seed.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy giống lúa")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Seed identified by the id in the request
exports.update = async (req, res) => {
     Seed.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy giống lúa")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Seed with the specified id in the request
exports.delete = async (req, res) => {
     Seed.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy giống lúa có mã ${req.params.id}`)
            } else {
                res.redirect("Lỗi trong quá trình xóa giống lúa!!");
            }
        } else res.send(data);
    });
};

