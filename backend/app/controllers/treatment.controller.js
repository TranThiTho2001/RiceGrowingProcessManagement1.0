const Treatment = require("../models/treatment.model");
const config = require("../config");

// Create and Save 
exports.store = async (req, res) => {
     // Create 
     const treatment = new Treatment({
          Pesticide_id: req.body.Pesticide_id,
          Epidemic_id: req.body.Epidemic_id,
     });
     // Save Treatment in the database
     Treatment.create(treatment, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình xử lý.")
          else res.send(data);
     });
};

// Retrieve all Treatment from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     Treatment.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

exports.findbyEidemicid = async (req, res) => {
     const id = req.params.Epidemic_id;
     Treatment.findEpidemicId(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

exports.findbyEidemicName = async (req, res) => {
     const  name = req.query.name;
     Treatment.findByEpidemicName(name, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

exports.findbyPesticideid = async (req, res) => {
     const  id = req.params.Pesticide_id;
     Treatment.findByPesticideid(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

exports.findbyPesticideName = async (req, res) => {
     const  name = req.query.name;
     Treatment.findByPesticideName(name, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

// Update a Treatment identified by the id in the request
exports.update = async (req, res) => {
     Treatment.updateById(
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

// Delete a Treatment with the specified id in the request
exports.delete = async (req, res) => {
     Treatment.remove(req.params.Pesticide_id, req.params.Epidemic_id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy ${req.params.Pesticide_id} và  ${req.params.Epidemic_id}`)
               } else {
                    res.send("Lỗi trong quá trình xóa quyền giám sát!!");
               }
          } else res.send(data);
     });
};


