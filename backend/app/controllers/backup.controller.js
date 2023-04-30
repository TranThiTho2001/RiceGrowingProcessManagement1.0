const Backup = require("../models/backup.model");
const config = require("../config");
const cron = require('node-cron');
const express = require("express");
const cors = require("cors");const multer = require('multer');
const moment = require('moment');
const fs = require('fs');
const spawn = require('child_process').spawn;
const mysqldump = require('mysqldump');
const db = require('../models/db');
// Create and Save 

exports.store = async (newbackup, res) => {

     // Save Backup in the database
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

// exports.findbyFertilizerId = async (req, res) => {
//     const Fertilizer_id= req.params.Fertilizer_id;
//     Backup.findbyFertilizerId(Fertilizer_id, (err, data) => {
//         if (err) {
//             if (err.kind === "not_found") {
//                 res.send("Không tìm thấy tỉ lệ")
//             } else {
//                 res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
//             }
//         } else res.send(data)
//     })
// };



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

