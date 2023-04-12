const Province = require("../models/province.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const crop = new Province({
        Province_id: req.body.Province_id,
        Province_name: req.body.Province_name,
    });
    // Save Province in the database
    Province.create(crop, (err, data) => {
        if (err)
            res.send("Không thể tạo tỉnh mới")
        else res.send(data);
    });
};

// Retrieve all Province from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Province.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else {
            res.send(data);
        }
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Province.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy tỉnh")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Province identified by the id in the request
exports.update = async (req, res) => {
     Province.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy tỉnh")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Province with the specified id in the request
exports.delete = async (req, res) => {
     Province.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy tỉnh có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa tỉnh thành!!");
            }
        } else res.send(data);
    });
};

