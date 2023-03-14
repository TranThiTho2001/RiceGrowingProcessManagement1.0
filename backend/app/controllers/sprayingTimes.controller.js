const SprayingTimes  = require("../models/sprayingTimes.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
     // Create 
     const sprayingTimes = new SprayingTimes({
          RiceCropInformation_id: req.body.RiceCropInformation_id,
          Pesticide_id: req.body.Pesticide_id,
          DevelopmentStage_id: req.body.DevelopmentStage_id,
          Employee_id: req.body.Employee_id,
          SprayingTimes_times: req.body.SprayingTimes_times,
          SprayingTimes_amount: req.body.SprayingTimes_amount,
          SprayingTimes_startDate: req.body.SprayingTimes_startDate,
          SprayingTimes_endDate: req.body.SprayingTimes_endDate,
          SprayingTimes_temperature: req.body.SprayingTimes_temperature,
          SprayingTimes_humidity: req.body.SprayingTimes_humidity,
          SprayingTimes_precipitation: req.body.SprayingTimes_precipitation
     });
     // Save sprayingTimes in the database
     SprayingTimes.create(sprayingTimes, (err, data) => {
          if (err)
               res.send("Không thể tạo lần phun thuốc mới.")
          else res.send(data);
     });
};

// Retrieve all SprayingTimes from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     SprayingTimes.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

exports.findbyIdRiceCropInformation = async (req, res) => {
     const id = req.params.RiceCropInformation_id;
     SprayingTimes.findByIdRiceCropInformation(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy lần phun thuốc mới.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};


exports.findbyname = async (req, res) => {
     const  name = req.query.name;
    const  id = req.params.RiceCropInformation_id;
     SprayingTimes.findByName(name,id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy lần phun thuốc mới.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};
// Update a SprayingTimes identified by the id in the request
exports.update = async (req, res) => {
     SprayingTimes.updateById(
          req.params.RiceCropInformation_id,
          req.params.Pesticide_id,
          req.params.SprayingTimes_times,
          req.body,
          (err, data) => {
               if (err) {
                    if (err.kind === "not_found") {
                         res.send("Không tìm thấy lần phun thuốc.")
                    } else {
                         res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                    }
               } else res.send(data)
          }
     );
};

// Delete a SprayingTimes with the specified id in the request
exports.delete = async (req, res) => {
     SprayingTimes.remove(req.params.RiceCropInformation_id, req.params.Pesticide_id, req.params.SprayingTimes_times, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy lần phun thuốc có mã vụ mùa ${req.params.RiceCropInformation_id} và mã thuốc ${req.params.Pesticide_id}`)
               } else {
                    res.redirect("Lỗi trong quá trình xóa lần phun thuốc!!");
               }
          } else res.send(data);
     });
};


