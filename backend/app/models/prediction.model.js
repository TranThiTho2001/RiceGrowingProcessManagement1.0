const sql = require("./db");

const Prediction = function (prediction) { 
     this.Prediction_N = prediction.N;
     this.Prediction_P = prediction.P;
     this.Prediction_K = prediction.K;
     this.Algorithm_id = prediction.Algorithm_id;
     this.Prediction_id = prediction.Prediction_id;
     this.Prediction_date = prediction.Prediction_date;
     this.Prediction_yield = prediction.Prediction_yield;
     this.Prediction_windSpeed = prediction.Prediction_windSpeed;
     this.Prediction_humitidity = prediction.Prediction_humitidity;
     this.Prediction_temperature = prediction.Prediction_temperature;
     this.RiceCropInformation_id = prediction.RiceCropInformation_id;
     this.Prediction_precipitation = prediction.Prediction_precipitation;
     this.Prediction_solarRadiation = prediction.Prediction_solarRadiation;
}

Prediction.create = (newPrediction, result) => {
     sql.query("INSERT INTO Prediction SET ?", newPrediction, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create RiceCropInformation: ", { id: res.insertId, ...newPrediction });
          result(null, { id: res.insertId, ...newPrediction });
     });
};

//find by Prediction_id
Prediction.findById = (id, result) => {
     sql.query(`SELECT * FROM Prediction` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = Prediction.RiceCropInformation_id` +
          ` JOIN Algorithm on Algorithm.Algorithm_id = Prediction.Algorithm_id `+
          ` WHERE Prediction.Prediction_id like '${id}'`, (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(err, null);
                    return;
               }
               if (res.length) {
                    result(null, res[0]);
                    return;
               }
               // not found Prediction with the id
               result({ kind: "not_found" }, null);
          });
};

// Retrieve all Prediciton from the database (with condition).
Prediction.getAll = (name, result) => {
     let query = `SELECT * FROM  Prediction` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = Prediction.RiceCropInformation_id `+
          ` JOIN Algorithm on Algorithm.Algorithm_id = Prediction.Algorithm_id `;
     if (name) {
          query += ` WHERE RiceCropInformation.RiceCropInformation_name LIKE '%${name}%'`;
     }
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          result(null, res);
     });
};

//find by RiceCropInformation_id
Prediction.findByRiceCropInformationId = (id, result) => {
     let query = `SELECT * FROM Prediction` +
               ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = Prediction.RiceCropInformation_id` +
               ` JOIN Algorithm on Algorithm.Algorithm_id = Prediction.Algorithm_id `+
               ` WHERE Prediction.RiceCropInformation_id LIKE '%${id}%'`;
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          result(null, res);
     });
};

// Delete a Prediction with the specified id in the request
Prediction.remove = (id, result) => {
     sql.query("DELETE FROM RiceCropInformation WHERE RiceCropInformation_id = ?", id, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.affectedRows == 0) {
               // not found RiceCropInformation with the id
               result({ kind: "not_found" }, null);
               return;
          }
          console.log("deleted RiceCropInformation with id: ", id);
          result(null, res);
     });
};

Prediction.removeAll = result => {
     sql.query("DELETE FROM RiceCropInformation", (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log(`deleted ${res.affectedRows} RiceCropInformation`);
          result(null, res);
     });
};

module.exports = Prediction;