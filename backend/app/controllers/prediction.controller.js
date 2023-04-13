const Prediction = require("../models/prediction.model");
const config = require("../config");
const moment = require('moment');
const file = "D:/HOC/HK2_2022_2023/Luan_Van_Tot_Nghiep/Project/RiceGrowingProcessManagement1.0/backend/predictionModel/LinearRegression.py";
// Create and Save 
exports.store = async (req, res) => {
     var yield = 0;
     var temp = new Object();
     temp.crop = req.body.crop;
     temp.precipitation = req.body.precipitation;
     temp.temperature = req.body.temperature;
     temp.humitidity = req.body.humitidity;
     temp.windSpeed =  req.body.windSpeed;
     temp.solarRadiation = req.body.solarRadiation;
     temp.area = req.body.area;
     const { spawn } = require('child_process');
     const pyProg = spawn('python', [`${file}`, JSON.stringify(temp)]);
     pyProg.stdout.on('data', function (data) {
          yield = String(data.toString()).slice(0, String(data.toString()).indexOf("\r\n"));
          yield = (String(yield).slice(1,));
          yield = (String(yield).slice(0,(String(yield).length-1)));
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
               Prediction_solarRadiation: req.body.solarRadiation
          });
console.log(prediciton)
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

exports.findByRiceCropInformationid = async (req, res) => {
     const id = req.params.RiceCropInformation_id;
     Prediction.findByRiceCropInformation(id, (err, data) => {
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



