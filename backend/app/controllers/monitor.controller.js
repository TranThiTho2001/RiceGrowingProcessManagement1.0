const Monitor = require("../models/monitor.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
     // Create 
     const monitor = new Monitor({
          Employee_id: req.body.Employee_id,
          RiceCropInformation_id: req.body.RiceCropInformation_id,
     });
     // Save Monitor in the database
     Monitor.create(monitor, (err, data) => {
          if (err)
               res.send("Không thể tạo quyền giám sát mới.")
          else res.send(data);
     });
};

// Retrieve all Monitor from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     Monitor.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

exports.findbyIdRiceCropInformation = async (req, res) => {
     const id = req.params.id;
     Monitor.findByIdRiceCropInformation(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy quyền giám sát.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

// Update a Monitor identified by the id in the request
exports.update = async (req, res) => {
     Monitor.updateById(
          req.params.id,
          req.body,
          (err, data) => {
               if (err) {
                    if (err.kind === "not_found") {
                         res.send("Không tìm thấy quyền giám sát.")
                    } else {
                         res.send("Đã xảy ra lỗi trong quá trình cập nhật thông tin!")
                    }
               } else res.send(data)
          }
     );
};

// Delete a Monitor with the specified id in the request
exports.delete = async (req, res) => {
     Monitor.remove(req.params.RiceCropInformation_id, req.params.Employee_id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy quyền giám sát có mã vụ mùa ${req.params.RiceCropInformation_id} và mã nhân viên ${req.params.Employee_id}`)
               } else {
                    res.redirect("Lỗi trong quá trình xóa quyền giám sát!!");
               }
          } else res.send(data);
     });
};


