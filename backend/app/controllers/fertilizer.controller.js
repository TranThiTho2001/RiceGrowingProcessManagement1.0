const Fertilizer = require("../models/fertilizer.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const fertilizer = new Fertilizer({
        Fertilizer_id: req.body.Fertilizer_id,
        Fertilizer_name: req.body.Fertilizer_name,
        Fertilizer_supplier: req.body.Fertilizer_supplier,
        Fertilizer_uses: req.body.Fertilizer_uses,
        Fertilizer_directionsForUse: req.body.Fertilizer_directionsForUse
     });
    // Save Fertilizer in the database
    Fertilizer.create(fertilizer, (err, data) => {
        if (err)
            res.send("Không thể tạo một loại phân bón mới")
        else res.send(data);
    });
};

// Retrieve all Fertilizer from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Fertilizer.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Fertilizer.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy loại phân bón.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Fertilizer identified by the id in the request
exports.update = async (req, res) => {
     Fertilizer.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy loại phân bón.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Fertilizer with the specified id in the request
exports.delete = async (req, res) => {
     Fertilizer.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy loại phân bón có mã ${req.params.id}.`)
            } else {
                res.send("Lỗi trong quá trình xóa loại phân bón!!");
            }
        } else res.send(data);
    });
};

