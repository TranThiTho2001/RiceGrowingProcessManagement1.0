const sql = require("./db");

const FertilizerTimes = function (fertilizerTimes) {
     this.RiceCropInformation_id = fertilizerTimes.RiceCropInformation_id;
     this.Fertilizer_id = fertilizerTimes.Fertilizer_id;
     this.DevelopmentStage_id = fertilizerTimes.DevelopmentStage_id;
     this.Employee_id = fertilizerTimes.Employee_id;
     this.FertilizerTimes_times = fertilizerTimes.times;
     this.FertilizerTimes_amount = fertilizerTimes.amount;
     this.FertilizerTimes_startDate = fertilizerTimes.startDate;
     this.FertilizerTimes_endDate = fertilizerTimes.endDate;
     this.FertilizerTimes_temperature = fertilizerTimes.temperature;
     this.FertilizerTimes_radiation = fertilizerTimes.radiation;
     this.FertilizerTimes_precipitation = fertilizerTimes.precipitation
}

FertilizerTimes.create = (newFertilizerTimes, result) => {
     console.log(newFertilizerTimes);
     sql.query("INSERT INTO FertilizerTimes SET ?", newFertilizerTimes, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create FertilizerTimes: ", { id: res.insertId, ...newFertilizerTimes });
          result(null, { id: res.insertId, ...newFertilizerTimes });
     });
};

FertilizerTimes.findByIdRiceCropInformation = (id, result) => {
     sql.query(`SELECT * FROM FertilizerTimes WHERE RiceCropInformation_id like '${id}'`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.length) {
               result(null, res);
               return;
          }
          // not found FertilizerTimes with the id
          result({ kind: "not_found" }, null);
     });
};

FertilizerTimes.getAll = (Fertilizer_id, result) => {
     let query = "SELECT * FROM FertilizerTimes";
     if (Fertilizer_id) {
          query += ` WHERE Fertilizer_id LIKE '%${Fertilizer_id}%'`;
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

FertilizerTimes.updateById = (riceCropInformation_id, Fertilizer_id, times, fertilizerTimes, result) => {
     console.log(fertilizerTimes.amount, fertilizerTimes.startDate);
     sql.query(
          "UPDATE FertilizerTimes SET Employee_id = ?, DevelopmentStage_id = ?, FertilizerTimes_amount = ?, FertilizerTimes_startDate = ?, FertilizerTimes_endDate = ?, FertilizerTimes_temperature = ?, FertilizerTimes_radiation = ?, FertilizerTimes_precipitation = ? WHERE (RiceCropInformation_id = ? And Fertilizer_id = ? and FertilizerTimes_times = ?)",
          [fertilizerTimes.Employee_id, fertilizerTimes.DevelopmentStage_id, fertilizerTimes.amount, fertilizerTimes.startDate, fertilizerTimes.endDate, fertilizerTimes.temperature, fertilizerTimes.radiation, fertilizerTimes.precipitation, riceCropInformation_id, Fertilizer_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(null, err);
                    return;
               }
               if (res.affectedRows == 0) {
                    // not found FertilizerTimes with the id
                    result({ kind: "not_found" }, null);
                    return;
               }
               result(null, { riceCropInformation_id: riceCropInformation_id, ...fertilizerTimes });

          }
     );
};

FertilizerTimes.remove = (riceCropInformation_id, Fertilizer_id, times, result) => {
     sql.query(`DELETE FROM FertilizerTimes WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Fertilizer_id LIKE '${Fertilizer_id}' AND FertilizerTimes_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          if (res.affectedRows == 0) {
               // not found FertilizerTimes with the id
               result({ kind: "not_found" }, null);
               return;
          }
          console.log("deleted FertilizerTimes with id: ", riceCropInformation_id);
          result(null, res);
     });
};

FertilizerTimes.removeAll = result => {
     sql.query("DELETE FROM FertilizerTimes", (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          console.log(`deleted ${res.affectedRows} FertilizerTimes`);
          result(null, res);
     });
};

module.exports = FertilizerTimes;