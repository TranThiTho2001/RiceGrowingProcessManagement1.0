const FertilizerTimes  = require("../models/fertilizerTimes.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
     // Create 
     const fertilizerTimes = new FertilizerTimes({
          RiceCropInformation_id: req.body.RiceCropInformation_id,
          Fertilizer_id: req.body.Fertilizer_id,
          DevelopmentStage_id: req.body.DevelopmentStage_id,
          Employee_id: req.body.Employee_id,
          FertilizerTimes_times: req.body.FertilizerTimes_times,
          FertilizerTimes_amount: req.body.FertilizerTimes_amount,
          FertilizerTimes_startDate: req.body.FertilizerTimes_startDate,
          FertilizerTimes_endDate: req.body.FertilizerTimes_endDate,
          temperatFertilizerTimes_temperatureure: req.body.FertilizerTimes_temperature,
          FertilizerTimes_humidity: req.body.FertilizerTimes_humidity,
          FertilizerTimes_precipitation: req.body.FertilizerTimes_precipitation
     });
     // Save FertilizerTimes in the database
     FertilizerTimes.create(fertilizerTimes, (err, data) => {
          if (err)
               res.send("Không thể tạo lần bón phân mới.")
          else res.send(data);
     });
};

// Retrieve all FertilizerTimes from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     FertilizerTimes.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

exports.findbyIdRiceCropInformation = async (req, res) => {
     const id = req.params.RiceCropInformation_id;
     FertilizerTimes.findByIdRiceCropInformation(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy lần bón phân.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};
exports.findbyname = async (req, res) => {
     const  name = req.query.name;
    const  id = req.params.RiceCropInformation_id;
     FertilizerTimes.findByName(name,id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy lần bón phân.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};
// Update a FertilizerTimes identified by the id in the request
exports.update = async (req, res) => {
     FertilizerTimes.updateById(
          req.params.RiceCropInformation_id,
          req.params.Fertilizer_id,
          req.params.FertilizerTimes_times,
          req.body,
          (err, data) => {
               if (err) {
                    if (err.kind === "not_found") {
                         res.send("Không tìm thấy lần bón phân.")
                    } else {
                         res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                    }
               } else res.send(data)
          }
     );
};

// Delete a FertilizerTimes with the specified id in the request
exports.delete = async (req, res) => {
     FertilizerTimes.remove(req.params.RiceCropInformation_id, req.params.Fertilizer_id, req.params.FertilizerTimes_times, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy lần bón phân có mã vụ mùa ${req.params.RiceCropInformation_id} và mã dịch bệnh ${req.params.Fertilizer_id}`)
               } else {
                    res.send("Lỗi trong quá trình lần bón phân!!");
               }
          } else res.send(data);
     });
};


