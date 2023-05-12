const EpidemicClassification = require("../models/epidemicClassification.model");
const config = require("../config");

exports.store = async (req, res) => {
    // Create 
    const epidemicsClassification = new EpidemicClassification({
        EpidemicClassification_id: req.body.EpidemicClassification_id,
        EpidemicClassification_name: req.body.EpidemicClassification_name,
    });
    // Save EpidemicClassification in the database
    EpidemicClassification.create(epidemicsClassification, (err, data) => {
        if (err)
            res.send("Không thể tạo một loại dịch bệnh mới")
        else res.send(data);
    });
};

// Retrieve all EpidemicClassification from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    EpidemicClassification.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

//find by  EpidemicClassification_id
exports.find = async (req, res) => {
    const id = req.params.id;
    EpidemicClassification.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy loại dịch bệnh")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};


