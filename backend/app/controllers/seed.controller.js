const Seed = require("../models/seed.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const seed = new Seed({
        Seed_id: req.body.Seed_id,
        Seed_name: req.body.Seed_name,
        Seed_characteristic: req.body.Seed_characteristic,
        Seed_supplier: req.body.Seed_supplier,
        Seed_image: req.body.Seed_image,
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

//find by Seed_id
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
                res.send("Lỗi trong quá trình xóa giống lúa!!");
            }
        } else res.send(data);
    });
};

