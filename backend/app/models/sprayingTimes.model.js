const sql = require("./db");

const SprayingTimes = function (sprayingTimes) {
     this.RiceCropInformation_id = sprayingTimes.RiceCropInformation_id;
     this.Pesticide_id = sprayingTimes.Pesticide_id;
     this.DevelopmentStage_id = sprayingTimes.DevelopmentStage_id;
     this.Employee_id = sprayingTimes.Employee_id;
     this.SprayingTimes_times = sprayingTimes.times;
     this.SprayingTimes_amount = sprayingTimes.amount;
     this.SprayingTimes_startDate = sprayingTimes.startDate;
     this.SprayingTimes_endDate = sprayingTimes.endDate;
     this.SprayingTimes_temperature = sprayingTimes.temperature;
     this.SprayingTimes_radiation = sprayingTimes.radiation;
     this.SprayingTimes_precipitation = sprayingTimes.precipitation
}

SprayingTimes.create = (newSprayingTimes, result) => {
     console.log(newSprayingTimes);
     sql.query("INSERT INTO SprayingTimes SET ?", newSprayingTimes, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create SprayingTimes: ", { id: res.insertId, ...newSprayingTimes });
          result(null, { id: res.insertId, ...newSprayingTimes });
     });
};

SprayingTimes.findByIdRiceCropInformation = (id, result) => {
     sql.query(`SELECT * FROM SprayingTimes WHERE RiceCropInformation_id like '${id}'`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.length) {
               result(null, res);
               return;
          }
          // not found SprayingTimes with the id
          result({ kind: "not_found" }, null);
     });
};

SprayingTimes.getAll = (Pesticide_id, result) => {
     let query = "SELECT * FROM SprayingTimes";
     if (Pesticide_id) {
          query += ` WHERE Pesticide_id LIKE '%${Pesticide_id}%'`;
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

SprayingTimes.updateById = (riceCropInformation_id, Pesticide_id, times, sprayingTimes, result) => {
     sql.query(
          "UPDATE SprayingTimes SET Employee_id = ?, DevelopmentStage_id = ?, SprayingTimes_amount = ?, SprayingTimes_startDate = ?, SprayingTimes_endDate = ?, SprayingTimes_temperature = ?, SprayingTimes_radiation = ?, SprayingTimes_precipitation = ? WHERE (RiceCropInformation_id = ? And Pesticide_id = ? and SprayingTimes_times = ?)",
          [sprayingTimes.Employee_id, sprayingTimes.DevelopmentStage_id, sprayingTimes.amount, sprayingTimes.startDate, sprayingTimes.endDate, sprayingTimes.temperature, sprayingTimes.radiation, sprayingTimes.precipitation, riceCropInformation_id, Pesticide_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(null, err);
                    return;
               }
               if (res.affectedRows == 0) {
                    // not found SprayingTimes with the id
                    result({ kind: "not_found" }, null);
                    return;
               }
               result(null, { riceCropInformation_id: riceCropInformation_id, ...sprayingTimes });

          }
     );
};

SprayingTimes.remove = (riceCropInformation_id, Pesticide_id, times, result) => {
     sql.query(`DELETE FROM SprayingTimes WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Pesticide_id LIKE '${Pesticide_id}' AND SprayingTimes_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          if (res.affectedRows == 0) {
               // not found SprayingTimes with the id
               result({ kind: "not_found" }, null);
               return;
          }
          console.log("deleted SprayingTimes with id: ", riceCropInformation_id);
          result(null, res);
     });
};

SprayingTimes.removeAll = result => {
     sql.query("DELETE FROM SprayingTimes", (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          console.log(`deleted ${res.affectedRows} SprayingTimes`);
          result(null, res);
     });
};

module.exports = SprayingTimes;