const Pesticide = require("../models/pesticide.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const pesticide = new Pesticide({
        Pesticide_id: req.body.Pesticide_id,
        Pesticide_name: req.body.Pesticide_name,
        Pesticide_supplier: req.body.Pesticide_supplier,
        Pesticide_component: req.body.Pesticide_component,
        Pesticide_directionsForUse: req.body.Pesticide_directionsForUse,
        Pesticide_uses: req.body.Pesticide_uses
     });
    // Save Pesticide in the database
    Pesticide.create(pesticide, (err, data) => {
        if (err)
            res.send("Không thể tạo một thuốc trừ sâu bệnh hại mới")
        else res.send(data);
    });
};

// Retrieve all Pesticide from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Pesticide.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Pesticide.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy thuốc trừ sâu bệnh hại.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Pesticide identified by the id in the request
exports.update = async (req, res) => {
     Pesticide.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy thuốc trừ sâu bệnh hại.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Pesticide with the specified id in the request
exports.delete = async (req, res) => {
     Pesticide.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy thuốc trừ sâu bệnh hại có mã ${req.params.id}.`)
            } else {
                res.send("Lỗi trong quá trình xóa thuốc trừ sâu bệnh hại!!");
            }
        } else res.send(data);
    });
};

