const Prediction = require("../models/prediction.model");
const config = require("../config");
const moment = require('moment');
const fileLinearRegression = process.cwd() + '/app/controllers/predictionModel/LinearRegression1.py';
const fileRandomForest = process.cwd() + '/app/controllers/predictionModel/RandomForestRegression1.py';

// Create and Save 
exports.store = async (req, res) => {
     var yield = 0;
     var temp = new Object();
     temp.crop = req.body.crop;
     temp.precipitation = req.body.precipitation;
     temp.temperature = req.body.temperature;
     temp.humitidity = req.body.humitidity;
     temp.windSpeed = req.body.windSpeed;
     temp.solarRadiation = req.body.solarRadiation;
     temp.area = req.body.area;
     temp.N = req.body.N;
     temp.P = req.body.P;
     temp.K = req.body.K;
     const regression = req.body.Algorithm_id;
     const { spawn } = require('child_process');
     var pyProg = "";
     if (regression == 1) {
          pyProg = spawn("python", [`${fileLinearRegression}`, JSON.stringify(temp)]);
     }
     else {
          pyProg = spawn("python", [`${fileRandomForest}`, JSON.stringify(temp)]);
     }

     pyProg.stdout.on('data', function (data) {
          yield = String(data.toString()).slice(0, String(data.toString()).indexOf("\r\n"));
          yield = (String(yield).slice(1,));
          yield = (String(yield).slice(0, (String(yield).length - 1)));

          // create new prediction
          const prediciton = new Prediction({
               Prediction_id: null,
               Prediction_date: moment().format('YYYY-MM-DD HH:mm:ss'),
               Prediction_yield: yield,
               RiceCropInformation_id: req.params.RiceCropInformation_id,
               Prediction_precipitation: req.body.precipitation,
               Prediction_temperature: req.body.temperature,
               Prediction_humitidity: req.body.humitidity,
               Prediction_windSpeed: req.body.windSpeed,
               Prediction_solarRadiation: req.body.solarRadiation,
               Algorithm_id: req.body.Algorithm_id,
               N: req.body.N,
               P: req.body.P,
               K: req.body.K,
          });

          // save prediciton
          Prediction.create(prediciton, (err, data) => {
               if (err)
                    res.send("Lỗi trong quá trình dự đoán năng suất lúa.")
               else res.send(data);
          });
     });
};

// Retrieve all Prediciton from the database (with condition).
exports.findAll = async (req, res) => {
     const name = req.query.name;
     Prediction.getAll(name, (err, data) => {
          if (err)
               res.send("Lỗi trong quá trình tìm kiếm.")
          else res.send(data);
     });
};

//find by Prediction_id
exports.findById = async (req, res) => {
     const id = req.params.id;
     Prediction.findById(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy kết quả dự đoán.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

//find by RiceCropInformation_id
exports.findByRiceCropInformationid = async (req, res) => {
     const id = req.params.RiceCropInformation_id;
     Prediction.findByRiceCropInformationId(id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send("Không tìm thấy kết quả dự đoán.")
               } else {
                    res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
               }
          } else res.send(data)
     })
};

// Delete a Prediction with the specified id in the request
exports.delete = async (req, res) => {
     Prediction.remove(req.params.id, (err, data) => {
          if (err) {
               if (err.kind === "not_found") {
                    res.send(`Không tìm thấy thuốc trừ sâu bệnh hại có mã ${req.params.id}.`)
               } else {
                    res.send("Lỗi trong quá trình xóa thuốc trừ sâu bệnh hại!!");
               }
          } else res.send(data);
     });
};



