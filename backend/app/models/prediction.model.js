const sql = require("./db");

const Prediction = function (prediction) {
     this.Prediction_id = prediction.Prediction_id;
     this.Prediction_date = prediction.Prediction_date;
     this.Prediction_yield = prediction.Prediction_yield;
     this.RiceCropInformation_id = prediction.RiceCropInformation_id;
     this.Prediction_precipitation = prediction.Prediction_precipitation;
     this.Prediction_temperature = prediction.Prediction_temperature;
     this.Prediction_humitidity = prediction.Prediction_humitidity;
     this.Prediction_windSpeed = prediction.Prediction_windSpeed;
     this.Prediction_solarRadiation = prediction.Prediction_solarRadiation
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

Prediction.findById = (id, result) => {
     sql.query(`SELECT * FROM Prediction` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = Prediction.RiceCropInformation_id` +
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

Prediction.getAll = (name, result) => {
     let query = `SELECT * FROM  Prediction` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = Prediction.RiceCropInformation_id`;
     if (name) {
          query += ` WHERE RiceCropInformation.RiceCropInformation_name LIKE '%${name}%'`;
     }
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          result(null, res);
     });
};

Prediction.findByRiceCropInformationid = (id, result) => {
     let query = `SELECT * FROM RSELECT * FROM Prediction` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = Prediction.RiceCropInformation_id`
          + `where Prediction.RiceCropInformation_id LIKE '%${id}%'`;
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          result(null, res);
     });
};

Prediction.findByArableLand = (name, id, result) => {
     let query = "SELECT * FROM RiceCropInformation JOIN Monitor on Monitor.RiceCropInformation_id = RiceCropInformation.RiceCropInformation_id" +
          ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
          ` JOIN ArableLand on ArableLand.ArableLand_id= RiceCropInformation.ArableLand_id` +
          ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id`
     if (name) {
          query += ` WHERE  LIKE ArableLand.ArableLand_name '%${name}%' or ArableLand.ArableLand_id LIKE '%${name}%'`;
     }
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          result(null, res);
     });
};

Prediction.updateById = (id, riceCropInformation, result) => {
     sql.query(
          "UPDATE RiceCropInformation SET Seed_id = ?, RiceCropInformation_name = ?, RiceCropInformation_sowingDate = ?, RiceCropInformation_harvestDate = ?, RiceCropInformation_yield = ?, ArableLand_id = ? WHERE RiceCropInformation_id = ?",
          [riceCropInformation.Seed_id, riceCropInformation.RiceCropInformation_name, riceCropInformation.RiceCropInformation_sowingDate, riceCropInformation.RiceCropInformation_harvestDate, riceCropInformation.RiceCropInformation_yield, riceCropInformation.ArableLand_id, id],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(null, err);
                    return;
               }
               if (res.affectedRows == 0) {
                    // not found RiceCropInformation with the id
                    result({ kind: "not_found" }, null);
                    return;
               }
               console.log("updated RiceCropInformation: ", { id: id, ...riceCropInformation });
               result(null, { id: id, ...riceCropInformation });

          }
     );
};

Prediction.remove = (id, result) => {
     sql.query("DELETE FROM RiceCropInformation WHERE RiceCropInformation_id = ?", id, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
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
               result(null, err);
               return;
          }
          console.log(`deleted ${res.affectedRows} RiceCropInformation`);
          result(null, res);
     });
};

module.exports = Prediction;