const EpidemicTimes  = require("../models/epidemicTimes.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
     // Create 
     const epidemicTimes = new EpidemicTimes({
          RiceCropInformation_id: req.body.RiceCropInformation_id,
          Epidemic_id: req.body.Epidemic_id,
          DevelopmentStage_id: req.body.DevelopmentStage_id,
          Employee_id: req.body.Employee_id,
          EpidemicTimes_times: req.body.EpidemicTimes_times,
          EpidemicTimes_startDate: req.body.EpidemicTimes_startDate,
          EpidemicTimes_endDate: req.body.EpidemicTimes_endDate,
          EpidemicTimes_temperature: req.body.EpidemicTimes_temperature,
          EpidemicTimes_radiation: req.body.EpidemicTimes_radiation,
          EpidemicTimes_precipitation: req.body.EpidemicTimes_precipitation
     });
     // Save EpidemicTimes in the database
     EpidemicTimes .create(epidemicTimes, (err, data) => {
          if (err)
               res.send("Không thể tạo lần bị dịch bệnh mới.")
          else res.send(data);
     });
};

// Retrieve all EpidemicTimes from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     EpidemicTimes.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

exports.findbyIdRiceCropInformation = async (req, res) => {
     const id = req.params.RiceCropInformation_id;
     EpidemicTimes.findByIdRiceCropInformation(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy lần bị dịch bệnh.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

// Update a EpidemicTimes identified by the id in the request
exports.update = async (req, res) => {
     console.log( req.params.RiceCropInformation_id,
          req.params.Epidemic_id,
          req.params.EpidemicTimes_times);
     EpidemicTimes.updateById(
          req.params.RiceCropInformation_id,
          req.params.Epidemic_id,
          req.params.EpidemicTimes_times,
          req.body,
          (err, data) => {
               if (err) {
                    if (err.kind === "not_found") {
                         res.send("Không tìm thấy lần bị dịch bệnh.")
                    } else {
                         res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                    }
               } else res.send(data)
          }
     );
};

// Delete a EpidemicTimes with the specified id in the request
exports.delete = async (req, res) => {
     EpidemicTimes.remove(req.params.RiceCropInformation_id, req.params.Epidemic_id, req.params.EpidemicTimes_times, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy lần bị dịch bệnh có mã vụ mùa ${req.params.RiceCropInformation_id} và mã dịch bệnh ${req.params.Epidemics_id}`)
               } else {
                    res.redirect("Lỗi trong quá trình xóa lần bị dịch bệnh!!");
               }
          } else res.send(data);
     });
};


