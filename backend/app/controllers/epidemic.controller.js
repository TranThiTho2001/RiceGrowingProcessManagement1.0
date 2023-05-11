const Epidemic = require("../models/epidemic.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const epidemic = new Epidemic({
        Epidemic_id: req.body.Epidemic_id,
        Epidemic_name: req.body.Epidemic_name,
        Epidemic_indication: req.body.Epidemic_indication,
        Epidemic_timeOfDevelopment: req.body.Epidemic_timeOfDevelopment,
        Epidemic_developmentEnvironment: req.body.Epidemic_developmentEnvironment,
        Epidemic_Harm: req.body.Epidemic_Harm,
        EpidemicClassification_id: req.body.EpidemicClassification_id,
        Epidemic_image: req.body.Epidemic_image,
     });
    // Save Epidemic in the database
    Epidemic.create(epidemic, (err, data) => {
        if (err)
            res.send("Không thể tạo một dịch bệnh mới")
        else res.send("Thêm thành công");
    });
};

// Retrieve all Epidemic from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Epidemic.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    Epidemic.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy dịch bệnh.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Epidemic identified by the id in the request
exports.update = async (req, res) => {
     Epidemic.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy dịch bệnh.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Epidemic with the specified id in the request
exports.delete = async (req, res) => {
     Epidemic.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy dịch bệnh có mã ${req.params.id}.`)
            } else {
                res.send("Lỗi trong quá trình xóa dịch bệnh!!");
            }
        } else res.send(data);
    });
};

