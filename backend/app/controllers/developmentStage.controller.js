const DevelopmentStage = require("../models/developmentStage.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const developmentStage = new DevelopmentStage({
        DevelopmentStage_id: req.body.DevelopmentStage_id,
        DevelopmentStage_name: req.body.DevelopmentStage_name,
    });
    // Save DevelopmentStage in the database
    DevelopmentStage.create(developmentStage, (err, data) => {
        if (err)
            res.send("Không thể tạo giai đoạn sinh trưởng mới")
        else res.send(data);
    });
};

// Retrieve all DevelopmentStage from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    DevelopmentStage.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    DevelopmentStage.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy giai đoạn sinh trưởng.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a DevelopmentStage identified by the id in the request
exports.update = async (req, res) => {
     DevelopmentStage.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy giai đoạn sinh trưởng.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a DevelopmentStage with the specified id in the request
exports.delete = async (req, res) => {
     DevelopmentStage.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy giai đoạn sinh trưởng có mã ${req.params.id}`)
            } else {
                res.redirect("Lỗi trong quá trình xóa giai đoạn sinh trưởng!!");
            }
        } else res.send(data);
    });
};

