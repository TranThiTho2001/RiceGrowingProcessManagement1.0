const sql = require("./db");

const FertilizerTimes = function (fertilizerTimes) {
     this.RiceCropInformation_id = fertilizerTimes.RiceCropInformation_id;
     this.Fertilizer_id = fertilizerTimes.Fertilizer_id;
     this.DevelopmentStage_id = fertilizerTimes.DevelopmentStage_id;
     this.Employee_id = fertilizerTimes.Employee_id;
     this.FertilizerTimes_times = fertilizerTimes.FertilizerTimes_times;
     this.FertilizerTimes_amount = fertilizerTimes.FertilizerTimes_amount;
     this.FertilizerTimes_startDate = fertilizerTimes.FertilizerTimes_startDate;
     this.FertilizerTimes_endDate = fertilizerTimes.FertilizerTimes_endDate;
}

FertilizerTimes.create = (newFertilizerTimes, result) => {
     console.log(newFertilizerTimes);
     sql.query("INSERT INTO FertilizerTimes SET ?", newFertilizerTimes, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          result(null, { id: res.insertId, ...newFertilizerTimes });
     });
};

//find by RiceCropInformation_id
FertilizerTimes.findByIdRiceCropInformation = (id, result) => {
     sql.query(`SELECT * FROM FertilizerTimes JOIN Fertilizer on Fertilizer.Fertilizer_id = FertilizerTimes.Fertilizer_id` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = FertilizerTimes.RiceCropInformation_id`+
          ` JOIN Employee on Employee.Employee_id = FertilizerTimes.Employee_id`+
          ` WHERE FertilizerTimes.RiceCropInformation_id like '${id}'`+ 
          ` ORDER BY FertilizerTimes.FertilizerTimes_times`, (err, res) => {
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

// Retrieve all FertilizerTimes from the database (with condition).
FertilizerTimes.getAll = (Fertilizer_id, result) => {
     let query = "SELECT * FROM FertilizerTimes "+
          ` JOIN Fertilizer on Fertilizer.Fertilizer_id = FertilizerTimes.Fertilizer_id` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = FertilizerTimes.RiceCropInformation_id`+
          ` JOIN Employee on Employee.Employee_id = FertilizerTimes.Employee_id ` ;
     if (Fertilizer_id) {
          query += ` WHERE Fertilizer_id LIKE '%${Fertilizer_id}%'`;
     }
     query += ` ORDER BY  FertilizerTimes.FertilizerTimes_times`;
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          result(null, res);
     });
};

// find by Fertilizer_name and RiceCropInformation_id
FertilizerTimes.findByName = (name,id, result) => {
     console.log(name)
     sql.query(`SELECT * FROM FertilizerTimes JOIN Fertilizer on Fertilizer.Fertilizer_id = FertilizerTimes.Fertilizer_id` +
          ` JOIN RiceCropInformation on RiceCropInformation.RiceCropInformation_id = FertilizerTimes.RiceCropInformation_id`+
          ` JOIN Employee on Employee.Employee_id = FertilizerTimes.Employee_id `+
          ` WHERE FertilizerTimes.RiceCropInformation_id like '${id}' AND Fertilizer.Fertilizer_name like '%${name}%' ORDER BY  FertilizerTimes.FertilizerTimes_times`, (err, res) => {
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

// Update a FertilizerTimes identified by the id in the request
FertilizerTimes.updateById = (riceCropInformation_id, Fertilizer_id, times, fertilizerTimes, result) => {
     sql.query(
          "UPDATE FertilizerTimes SET Employee_id = ?, DevelopmentStage_id = ?, FertilizerTimes_amount = ?, FertilizerTimes_startDate = ?, FertilizerTimes_endDate = ? WHERE (RiceCropInformation_id = ? And Fertilizer_id = ? and FertilizerTimes_times = ?)",
          [fertilizerTimes.Employee_id, fertilizerTimes.DevelopmentStage_id, fertilizerTimes.FertilizerTimes_amount, fertilizerTimes.FertilizerTimes_startDate, fertilizerTimes.FertilizerTimes_endDate, riceCropInformation_id, Fertilizer_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(err, null);
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

// Delete a FertilizerTimes with the specified id in the request
FertilizerTimes.remove = (riceCropInformation_id, Fertilizer_id, times, result) => {
     sql.query(`DELETE FROM FertilizerTimes WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Fertilizer_id LIKE '${Fertilizer_id}' AND FertilizerTimes_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
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

module.exports = FertilizerTimes;