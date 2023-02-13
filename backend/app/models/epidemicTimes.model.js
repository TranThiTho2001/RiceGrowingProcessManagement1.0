const sql = require("./db");

const EpidemicTimes = function (epidemicTimes) {
     this.RiceCropInformation_id = epidemicTimes.RiceCropInformation_id;
     this.Epidemics_id = epidemicTimes.Epidemics_id;
     this.DevelopmentStage_id = epidemicTimes.DevelopmentStage_id;
     this.Employee_id = epidemicTimes.Employee_id;
     this.EpidemicTimes_times = epidemicTimes.EpidemicTimes_times;
     this.EpidemicTimes_startDate = epidemicTimes.EpidemicTimes_startDate;
     this.EpidemicTimes_endDate = epidemicTimes.EpidemicTimes_endDate;
     this.EpidemicTimes_temperature = epidemicTimes.EpidemicTimes_temperature;
     this.EpidemicTimes_radiation = epidemicTimes.EpidemicTimes_radiation;
     this.EpidemicTimes_precipitation = epidemicTimes.EpidemicTimes_precipitation
}

EpidemicTimes.create = (newEpidemicTimes, result) => {
     console.log(newEpidemicTimes);
     sql.query("INSERT INTO EpidemicTimes SET ?", newEpidemicTimes, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create EpidemicTimes: ", { id: res.insertId, ...newEpidemicTimes });
          result(null, { id: res.insertId, ...newEpidemicTimes });
     });
};

EpidemicTimes.findByIdRiceCropInformation = (id, result) => {
     sql.query(`SELECT * FROM EpidemicTimes WHERE RiceCropInformation_id like '${id}'`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.length) {
               result(null, res);
               return;
          }
          // not found EpidemicTimes with the id
          result({ kind: "not_found" }, null);
     });
};

EpidemicTimes.getAll = (Epidemics_id, result) => {
     let query = "SELECT * FROM EpidemicTimes";
     if (Epidemics_id) {
          query += ` WHERE Epidemics_id LIKE '%${Epidemics_id}%'`;
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

EpidemicTimes.updateById = (riceCropInformation_id, Epidemics_id, times, epidemicTimes, result) => {
     sql.query(
          "UPDATE EpidemicTimes SET Employee_id = ?, DevelopmentStage_id = ?, EpidemicTimes_startDate = ?, EpidemicTimes_endDate = ?, EpidemicTimes_temperature = ?, EpidemicTimes_radiation = ?, EpidemicTimes_precipitation = ? WHERE (RiceCropInformation_id = ? And Epidemics_id = ? and EpidemicTimes_times = ?)",
          [epidemicTimes.Employee_id, epidemicTimes.DevelopmentStage_id, epidemicTimes.EpidemicTimes_startDate, epidemicTimes.EpidemicTimes_endDate, epidemicTimes.EpidemicTimes_temperature, epidemicTimes.EpidemicTimes_radiation, epidemicTimes.EpidemicTimes_precipitation, riceCropInformation_id, Epidemics_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(null, err);
                    return;
               }
               if (res.affectedRows == 0) {
                    // not found EpidemicTimes with the id
                    result({ kind: "not_found" }, null);
                    return;
               }
               result(null, { riceCropInformation_id: riceCropInformation_id, ...epidemicTimes });

          }
     );
};

EpidemicTimes.remove = (riceCropInformation_id, epidemics_id, times, result) => {
     sql.query(`DELETE FROM EpidemicTimes WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Epidemics_id LIKE '${epidemics_id}' AND EpidemicTimes_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          if (res.affectedRows == 0) {
               // not found EpidemicTimes with the id
               result({ kind: "not_found" }, null);
               return;
          }
          console.log("deleted EpidemicTimes with id: ", riceCropInformation_id);
          result(null, res);
     });
};

EpidemicTimes.removeAll = result => {
     sql.query("DELETE FROM EpidemicTimes", (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          console.log(`deleted ${res.affectedRows} EpidemicTimes`);
          result(null, res);
     });
};

module.exports = EpidemicTimes;