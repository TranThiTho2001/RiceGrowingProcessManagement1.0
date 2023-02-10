const ArableLand = require("../models/arableLand.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const arableLand = new ArableLand({
        id: req.body.id,
        location: req.body.location,
        soilId: req.body.soilId,
        area: req.body.area,
        owner: req.body.owner,
    });
    // Save ArableLand in the database
    ArableLand.create(arableLand, (err, data) => {
        if (err)
            res.send("Không thể tạo một đất canh tác mới")
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
                res.redirect("Lỗi trong quá trình xóa đất canh tác!!");
            }
        } else res.send(data);
    });
};

