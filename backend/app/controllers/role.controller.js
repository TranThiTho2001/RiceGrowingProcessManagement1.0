const Role = require("../models/role.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create a 
    const role = new Role({
        Role_id: req.body.Role_id,
        Role_name: req.body.Role_name,
    });
    // Save Role in the database
    Role.create(role, (err, data) => {
        if (err)
            res.send("Không thể tạo loại nhân viên mới")
        else res.send(data);
    });
};

// Retrieve all Role from the database (with condition).
exports.findAll = async (req, res) => {
    console.log("1")

    const name = req.query.name;

    Role.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Role.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy loại nhân viên")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Role identified by the id in the request
exports.update = async (req, res) => {
     Role.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy loại nhân viên")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin loại nhân viên!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Role with the specified id in the request
exports.delete = async (req, res) => {
     Role.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy loại nhân viên có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa loại nhân viên!!");
            }
        } else res.send(data);
    });
};

