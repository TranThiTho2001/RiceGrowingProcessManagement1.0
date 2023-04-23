const Algorithm = require("../models/algorithm.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const algorithm = new Algorithm({
        Algorithm_id: req.body.Algorithm_id,
        Algorithm_name: req.body.Algorithm_name,
    });
    // Save Algorithm in the database
    Algorithm.create(algorithm, (err, data) => {
        if (err)
            res.send("Không thể tạo một giải thuật mới")
        else res.send(data);
    });
};

// Retrieve all Algorithm from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Algorithm.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Algorithm.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy giải thuật")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Algorithm identified by the id in the request
exports.update = async (req, res) => {
     Algorithm.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy giải thuật")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Algorithm with the specified id in the request
exports.delete = async (req, res) => {
     Algorithm.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy giải thuật có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa giải thuật!!");
            }
        } else res.send(data);
    });
};

