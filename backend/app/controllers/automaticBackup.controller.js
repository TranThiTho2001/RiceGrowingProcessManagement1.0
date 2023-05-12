const Backup = require("../models/backup.model");
const config = require("../config");

// Create and Save 
exports.store = async (newBackup, req, res) => {

    // Save Backup in the database
    Backup.create(newBackup, (err, data) => {
        if (err)
            console.log("Không thể tạo một tỉ lệ mới")
        else console.log(data);
    });

};

// Retrieve all Backup from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Backup.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};


// Delete a Backup with the specified id in the request
exports.delete = async (req, res) => {
     Backup.remove(req.params.Fertilizer_id, req.params.Nutrient_id,  (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy tỉ lệ có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa tỉ lệ!!");
            }
        } else res.send(data);
    });
};

