const Contain = require("../models/contain.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const contain = new Contain({
        Contain_percent: req.body.Contain_percent,
        Fertilizer_id: req.body.Fertilizer_id,
        Nutrient_id: req.body.Nutrient_id,
    });

    // Save Contain in the database
    Contain.create(contain, (err, data) => {
        if (err)
            res.send("Không thể tạo một tỉ lệ mới")
        else res.send(data);
    });
};

// Retrieve all Contain from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Contain.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm")
        else res.send(data);
    });
};

// find by Fertilizer_id
exports.findbyFertilizerId = async (req, res) => {
    const Fertilizer_id = req.params.Fertilizer_id;
    Contain.findbyFertilizerId(Fertilizer_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy tỉ lệ")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// find by Nutrient_id
exports.findbyNutrientID = async (req, res) => {
     const Nutrient_id = req.params.Nutrient_id;
     Contain.findbyNutrientID(Nutrient_id, (err, data) => {
         if (err) {
             if (err.kind === "not_found") {
                 res.send("Không tìm thấy tỉ lệ")
             } else {
                 res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
             }
         } else res.send(data)
     })
 };

 // find by Nutrient_id and Fertilizer_id
 exports.findbyFertilizerAndNutrient = async (req, res) => {
     const Nutrient_id = req.params.Nutrient_id;
     const Fertilizer_id = req.params.Fertilizer_id;
     Contain.findbyFertilizerAndNutrient(Fertilizer_id, Nutrient_id, (err, data) => {
         if (err) {
             if (err.kind === "not_found") {
                 res.send("Không tìm thấy tỉ lệ")
             } else {
                 res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
             }
         } else res.send(data)
     })
 };

// Update a Contain identified by the Fertilizer_id and Nutrient_id in the request
exports.update = async (req, res) => {
     Contain.updateById(
        req.params.Fertilizer_id,
        req.params.Nutrient_id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy tỉ lệ")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a Contain with the specified Fertilizer_id and Nutrient_id in the request
exports.delete = async (req, res) => {
     Contain.remove(req.params.Fertilizer_id, req.params.Nutrient_id,  (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy tỉ lệ có mã ${req.params.id}`)
            } else {
                res.send("Lỗi trong quá trình xóa tỉ lệ!!");
            }
        } else res.send(data);
    });
};

