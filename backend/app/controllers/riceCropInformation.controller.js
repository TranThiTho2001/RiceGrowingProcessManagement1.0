const RiceCropInformation = require("../models/riceCropInformation.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
    // Create 
    const riceCropInformation = new RiceCropInformation({
        Seed_id: req.body.Seed_id,
        Crop_id: req.body.Crop_id, 
        ArableLand_id: req.body.ArableLand_id,
        RiceCropInformation_id: req.body.RiceCropInformation_id,
        RiceCropInformation_name: req.body.RiceCropInformation_name,
        RiceCropInformation_yield: req.body.RiceCropInformation_yield,
        RiceCropInformation_sowingDate: req.body.RiceCropInformation_sowingDate,
        RiceCropInformation_harvestDate: req.body.RiceCropInformation_harvestDate,
     });

    // Save RiceCropInformation in the database
    RiceCropInformation.create(riceCropInformation, (err, data) => {
        if (err)
            res.send("Không thể tạo vụ mùa lúa mới.")
        else res.send(data);
    });
};

// Retrieve all RiceCropInformation from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    RiceCropInformation.getAll(name, (err, data) => {
        if (err)
            res.send("Lỗi trong quá trình tìm kiếm.")
        else res.send(data);
    });
};

//find by RiceCropInformation_id
exports.find = async (req, res) => {
    const id = req.params.id;
    RiceCropInformation.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy vụ mùa lúa.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

//find by Employee_id and  RiceCropInformation_name 
exports.findbyEmployeeAndRiceCrop = async (req, res) => {
    const name = req.params.name;
    const id = req.params.Employee_id;
    RiceCropInformation.getByEmployeeAndRiceCrop(name, id,  (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy vụ mùa lúa.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

exports.findRiceCropHarvested = async (req, res) => {
    RiceCropInformation.findRiceCropHarvested( (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy vụ mùa lúa.")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a RiceCropInformation identified by the id in the request
exports.update = async (req, res) => {
     RiceCropInformation.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy vụ mùa lúa.")
                } else {
                    res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                }
            } else res.send(data)
        }
    );
};

// Delete a RiceCropInformation with the specified id in the request
exports.delete = async (req, res) => {
     RiceCropInformation.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy vụ mùa lúa có mã ${req.params.id}.`)
            } else {
                res.send("Lỗi trong quá trình xóa vụ mùa lúa!!");
            }
        } else res.send(data);
    });
};

