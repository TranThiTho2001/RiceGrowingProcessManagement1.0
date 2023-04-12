const sql = require("./db");

const EpidemicTimes = function (epidemicTimes) {
     this.RiceCropInformation_id = epidemicTimes.RiceCropInformation_id;
     this.Epidemic_id = epidemicTimes.Epidemic_id;
     this.DevelopmentStage_id = epidemicTimes.DevelopmentStage_id;
     this.Employee_id = epidemicTimes.Employee_id;
     this.EpidemicTimes_times = epidemicTimes.EpidemicTimes_times;
     this.EpidemicTimes_startDate = epidemicTimes.EpidemicTimes_startDate;
     this.EpidemicTimes_endDate = epidemicTimes.EpidemicTimes_endDate;
     this.EpidemicTimes_temperature = epidemicTimes.EpidemicTimes_temperature;
     this.EpidemicTimes_humidity = epidemicTimes.EpidemicTimes_humidity;
     this.EpidemicTimes_precipitation = epidemicTimes.EpidemicTimes_precipitation;
     this.EpidemicTimes_windSpeed = epidemicTimes.EpidemicTimes_windSpeed;
     this.EpidemicTimes_solarRadiation = epidemicTimes.EpidemicTimes_solarRadiation;
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
     sql.query(`SELECT * FROM EpidemicTimes`+
          ` JOIN Employee on Employee.Employee_id = EpidemicTimes.Employee_id` +
          ` JOIN Epidemic on Epidemic.Epidemic_id = EpidemicTimes.Epidemic_id` +
          ` Join Developmentstage on DevelopmentStage.DevelopmentStage_id = EpidemicTimes.DevelopmentStage_id` + 
          ` WHERE RiceCropInformation_id like '${id}' ORDER BY EpidemicTimes_times`, (err, res) => {
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
     let query = "SELECT * FROM EpidemicTimes"+
     ` JOIN Employee on Employee.Employee_id = EpidemicTimes.Employee_id` +
          ` JOIN Epidemic on Epidemic.Epidemic_id = EpidemicTimes.Epidemic_id` +
          ` Join Developmentstage on DevelopmentStage.DevelopmentStage_id = EpidemicTimes.DevelopmentStage_id` +
          ` Join RiceCropInformation on RiceCropInformation.RiceCropInformation_id = EpidemicTimes.RiceCropInformation_id`;
     if (Epidemics_id) {
          query += ` WHERE Epidemic_id LIKE '%${Epidemics_id}%' ORDER By EpidemicTimes_times`;
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



EpidemicTimes.findByName= (name,id, result) => {
     let query = "SELECT * FROM EpidemicTimes"+
     ` JOIN Employee on Employee.Employee_id = EpidemicTimes.Employee_id` +
          ` JOIN Epidemic on Epidemic.Epidemic_id = EpidemicTimes.Epidemic_id` +
          ` Join Developmentstage on DevelopmentStage.DevelopmentStage_id = EpidemicTimes.DevelopmentStage_id`;
     if (name) {
          query += ` WHERE Epidemic_name LIKE '%${name}%' AND RiceCropInformation_id like '${id}' ORDER BY EpidemicTimes_times`;
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

EpidemicTimes.updateById = (riceCropInformation_id, Epidemic_id, times, epidemicTimes, result) => {
     sql.query(
          "UPDATE EpidemicTimes SET Employee_id = ?, DevelopmentStage_id = ?, EpidemicTimes_startDate = ?, EpidemicTimes_endDate = ?, EpidemicTimes_temperature = ?, EpidemicTimes_humidity = ?, EpidemicTimes_precipitation = ?, Epidemic_id = ?, EpidemicTimes_solarRadiation = ?, EpidemicTimes_windSpeed = ?  WHERE (RiceCropInformation_id = ? and EpidemicTimes_times = ?)",
          [epidemicTimes.Employee_id, epidemicTimes.DevelopmentStage_id, epidemicTimes.EpidemicTimes_startDate, epidemicTimes.EpidemicTimes_endDate, epidemicTimes.EpidemicTimes_temperature, epidemicTimes.EpidemicTimes_humidity, epidemicTimes.EpidemicTimes_precipitation, Epidemic_id,epidemicTimes.EpidemicTimes_solarRadiation, epidemicTimes.EpidemicTimes_windSpeed, riceCropInformation_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(err, null);
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

EpidemicTimes.remove = (riceCropInformation_id, epidemic_id, times, result) => {
     sql.query(`DELETE FROM EpidemicTimes WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Epidemic_id LIKE '${epidemic_id}' AND EpidemicTimes_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
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
               result(err, null);
               return;
          }
          console.log(`deleted ${res.affectedRows} EpidemicTimes`);
          result(null, res);
     });
};

module.exports = EpidemicTimes;