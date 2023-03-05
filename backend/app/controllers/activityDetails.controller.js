const ActivityDetails = require("../models/activityDetails.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
     // Create 
     const activityDetails = new ActivityDetails({
          RiceCropInformation_id: req.body.RiceCropInformation_id,
          OtherActivities_id: req.body.OtherActivities_id,
          ActivityDetails_startDate: req.body.ActivityDetails_startDate,
          ActivityDetails_endDate: req.body.ActivityDetails_endDate,
          ActivityDetails_temperature: req.body.ActivityDetails_temperature,
          ActivityDetails_humidity: req.body.ActivityDetails_humidity,
          ActivityDetails_precipitation: req.body.ActivityDetails_precipitation,
          Employee_id: req.body.Employee_id,
          ActivityDetails_times: req.body.ActivityDetails_times,
          DevelopmentStage_id: req.body.DevelopmentStage_id
     });
     // Save ActivityDetails in the database
     ActivityDetails.create(activityDetails, (err, data) => {
          if (err)
               res.send("Không thể tạo chi tiết hoạt động mới.")
          else res.send(data);
     });
};

// Retrieve all ActivityDetails from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     ActivityDetails.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

exports.findbyIdRiceCropInformation = async (req, res) => {
     const id = req.params.RiceCropInformation_id;
     ActivityDetails.findByIdRiceCropInformation(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy chi tiết hoạt động.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

// Update a ActivityDetails identified by the id in the request
exports.update = async (req, res) => {
     ActivityDetails.updateById(
          req.params.RiceCropInformation_id,
          req.params.OtherActivities_id,
          req.params.ActivityDetails_times,
          req.body,
          (err, data) => {
               if (err) {
                    if (err.kind === "not_found") {
                         res.send("Không tìm thấy chi tiết hoạt động.")
                    } else {
                         res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                    }
               } else res.send(data)
          }
     );
};

// Delete a ActivityDetails with the specified id in the request
exports.delete = async (req, res) => {
     ActivityDetails.remove(req.params.RiceCropInformation_id, req.params.OtherActivities_id, req.params.ActivityDetails_times, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy chi tiết hoạt động có mã vụ mùa ${req.params.RiceCropInformation_id} và mã hoạt động ${req.params.OtherActivities_id}`)
               } else {
                    res.redirect("Lỗi trong quá trình xóa chi tiết hoạt động!!");
               }
          } else res.send(data);
     });
};


