const OtherActivities = require("../models/otherActivities.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const otherActivities = new OtherActivities({
        OtherActivities_id: req.body.OtherActivities_id,
        OtherActivities_name: req.body.OtherActivities_name,
    });

    // Save OtherActivities in the database
    OtherActivities.create(otherActivities, (err, data) => {
        if (err)
            res.send("Không thể tạo một hoạt động mới.")
        else res.send(data);
    });
};

// Retrieve all OtherActivities from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    OtherActivities.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

//find by OtherActivities_id
exports.find = async (req, res) => {
    const id = req.params.id;
    OtherActivities.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy hoạt động.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a OtherActivities identified by the id in the request
exports.update = async (req, res) => {
     OtherActivities.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy hoạt động.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a OtherActivities with the specified id in the request
exports.delete = async (req, res) => {
     OtherActivities.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy hoạt động có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa hoạt động!!");
            }
        } else res.send(data);
    });
};

