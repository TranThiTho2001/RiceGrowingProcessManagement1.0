const Backup = require("../models/backup.model");
const config = require("../config");
const db = require('../models/db');
const path = require('path');

// Create and Save 
exports.store = async (newbackup, res) => {
     Backup.create(newbackup, (err, data) => {
          if (err)
               res.send("Không thể tạo một tỉ lệ mới");
          else res.send(data);
     });
};

// Retrieve all Backup from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     Backup.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm")
          else res.send(data);
     });
};

exports.dowload = async (req, res) => {
     const fileName = req.params.link;
     const path = process.cwd() + '/app/backup/'+fileName;

     res.sendFile(path, function (err) {
          if (err) {
              console.log(err)
          } else {
              console.log('Sent:', fileName);
          }
      });
};

// Delete a Backup with the specified id in the request
exports.delete = async (req, res) => {
     Backup.remove(req.params.id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy tỉ lệ có mã ${req.params.id}`)
               } else {
                    res.send("Lỗi trong quá trình xóa tỉ lệ!!");
               }
          } else res.send(data);
     });
};

