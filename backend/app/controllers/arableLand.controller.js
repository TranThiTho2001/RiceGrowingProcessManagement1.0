const ArableLand = require("../models/arableLand.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const arableLand = new ArableLand({
        ArableLand_id: req.body.ArableLand_id,
        ArableLand_location: req.body.ArableLand_location,
        Soil_id: req.body.Soil_id,
        ArableLand_area: req.body.ArableLand_area,
        ArableLand_owner: req.body.ArableLand_owner,
        ArableLand_latitude: req.body.ArableLand_latitude,
        ArableLand_longitude: req.body.ArableLand_longitude,
        Province_id: req.body.Province_id,
    });
    // Save ArableLand in the database
    ArableLand.create(arableLand, (err, data) => {
        if (err)
            res.send("Không thể tạo một mẫu ruộng mới")
        else res.send(data);
    });
};

// Retrieve all ArableLand from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    ArableLand.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    ArableLand.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy đất canh tác.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a ArableLand identified by the id in the request
exports.update = async (req, res) => {
     ArableLand.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy đất canh tác.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a ArableLand with the specified id in the request
exports.delete = async (req, res) => {
     ArableLand.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy đất canh tác có mã ${req.params.id}.`)
            } else {
                res.send("Lỗi trong quá trình xóa đất canh tác!!");
            }
        } else res.send(data);
    });
};

