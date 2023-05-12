const sql = require("./db");

const SprayingTimes = function (sprayingTimes) {
     this.RiceCropInformation_id = sprayingTimes.RiceCropInformation_id;
     this.Pesticide_id = sprayingTimes.Pesticide_id;
     this.DevelopmentStage_id = sprayingTimes.DevelopmentStage_id;
     this.Employee_id = sprayingTimes.Employee_id;
     this.SprayingTimes_times = sprayingTimes.SprayingTimes_times;
     this.SprayingTimes_amount = sprayingTimes.SprayingTimes_amount;
     this.SprayingTimes_startDate = sprayingTimes.SprayingTimes_startDate;
     this.SprayingTimes_endDate = sprayingTimes.SprayingTimes_endDate;
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

//find by RiceCropInformation_id
SprayingTimes.findByIdRiceCropInformation = (id, result) => {
     sql.query(`SELECT * FROM SprayingTimes JOIN Employee ON Employee.Employee_id = SprayingTimes.Employee_id` +
          ` JOIN Pesticide ON Pesticide.Pesticide_id = SprayingTimes.Pesticide_id` + 
          ` JOIN Developmentstage ON developmentstage.DevelopmentStage_id = SprayingTimes.DevelopmentStage_id` +
          ` WHERE RiceCropInformation_id like '${id}' ORDER BY SprayingTimes.SprayingTimes_times`, (err, res) => {
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

// Retrieve all SprayingTimes from the database (with condition).
SprayingTimes.getAll = (Pesticide_id, result) => {
     let query = "SELECT * FROM SprayingTimes JOIN Employee ON Employee.Employee_id = SprayingTimes.Employee_id" +
               " JOIN Pesticide ON Pesticide.Pesticide_id = SprayingTimes.Pesticide_id" + 
               " JOIN Developmentstage ON developmentstage.DevelopmentStage_id = SprayingTimes.DevelopmentStage_id";
     if (Pesticide_id) {
          query += ` WHERE Pesticide_id LIKE '%${Pesticide_id}%' AND RiceCropInformation_id LIKE '${id}' ORDER BY SprayingTimes.SprayingTimes_times`;
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

SprayingTimes.findByName = (Pesticide_name,id, result) => {
     let query = "SELECT * FROM SprayingTimes JOIN Employee ON Employee.Employee_id = SprayingTimes.Employee_id" +
               " JOIN Pesticide ON Pesticide.Pesticide_id = SprayingTimes.Pesticide_id" + 
               " JOIN Developmentstage ON developmentstage.DevelopmentStage_id = SprayingTimes.DevelopmentStage_id";
     if (Pesticide_name) {
          query += ` WHERE Pesticide_name LIKE '%${Pesticide_name}%' AND RiceCropInformation_id LIKE '${id}' ORDER BY SprayingTimes.SprayingTimes_times`;
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

// Update a SprayingTimes identified by the id in the request
SprayingTimes.updateById = (riceCropInformation_id, Pesticide_id, times, sprayingTimes, result) => {
     sql.query(
          "UPDATE SprayingTimes SET Employee_id = ?, DevelopmentStage_id = ?, SprayingTimes_amount = ?, SprayingTimes_startDate = ?, SprayingTimes_endDate = ? WHERE (RiceCropInformation_id = ? And Pesticide_id = ? and SprayingTimes_times = ?)",
          [sprayingTimes.Employee_id, sprayingTimes.DevelopmentStage_id, sprayingTimes.SprayingTimes_amount, sprayingTimes.SprayingTimes_startDate, sprayingTimes.SprayingTimes_endDate,  riceCropInformation_id, Pesticide_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(err, null);
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

// Delete a SprayingTimes with the specified id in the request
SprayingTimes.remove = (riceCropInformation_id, Pesticide_id, times, result) => {
     sql.query(`DELETE FROM SprayingTimes WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Pesticide_id LIKE '${Pesticide_id}' AND SprayingTimes_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
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
               result(err, null);
               return;
          }
          console.log(`deleted ${res.affectedRows} SprayingTimes`);
          result(null, res);
     });
};

module.exports = SprayingTimes;