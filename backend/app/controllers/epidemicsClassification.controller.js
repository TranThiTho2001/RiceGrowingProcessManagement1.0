const EpidemicsClassification = require("../models/epidemicsClassification.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const epidemicsClassification = new EpidemicsClassification({
        id: req.body.id,
        name: req.body.name,
    });
    // Save EpidemicsClassification in the database
    EpidemicsClassification.create(epidemicsClassification, (err, data) => {
        if (err)
            res.send("Không thể tạo một loại dịch bệnh mới")
        else res.send(data);
    });
};

// Retrieve all EpidemicsClassification from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    EpidemicsClassification.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

exports.find = async (req, res) => {
    const id = req.params.id;
    EpidemicsClassification.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy loại dịch bệnh")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};


