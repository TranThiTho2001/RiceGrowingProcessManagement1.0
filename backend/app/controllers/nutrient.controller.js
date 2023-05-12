const Nutrient = require("../models/nutrient.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const nutrient = new Nutrient({
        Nutrient_id: req.body.Nutrient_id,
        Nutrient_name: req.body.Nutrient_name,
    });

    // Save Nutrient in the database
    Nutrient.create(nutrient, (err, data) => {
        if (err)
            res.send("Không thể tạo một chất dinh dưỡng mới")
        else res.send(data);
    });
};

// Retrieve all Nutrient from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Nutrient.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

//find by Nutrient_id
exports.find = async (req, res) => {
    const id = req.params.id;
    Nutrient.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy chất dinh dưỡng")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Nutrient identified by the id in the request
exports.update = async (req, res) => {
     Nutrient.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy chất dinh dưỡng")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Nutrient with the specified id in the request
exports.delete = async (req, res) => {
     Nutrient.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy chất dinh dưỡng có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa chất dinh dưỡng!!");
            }
        } else res.send(data);
    });
};

