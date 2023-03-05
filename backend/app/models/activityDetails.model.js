const sql = require("./db");

const ActivityDetails = function (activityDetails) {
     this.RiceCropInformation_id = activityDetails.RiceCropInformation_id;
     this.OtherActivities_id = activityDetails.OtherActivities_id;
     this.ActivityDetails_startDate = activityDetails.ActivityDetails_startDate;
     this.ActivityDetails_endDate = activityDetails.ActivityDetails_endDate;
     this.ActivityDetails_temperature = activityDetails.ActivityDetails_temperature;
     this.ActivityDetails_humidity = activityDetails.ActivityDetails_humidity;
     this.ActivityDetails_precipitation = activityDetails.ActivityDetails_precipitation;
     this.Employee_id = activityDetails.Employee_id;
     this.ActivityDetails_times = activityDetails.ActivityDetails_times;
     this.DevelopmentStage_id = activityDetails.DevelopmentStage_id;
}

ActivityDetails.create = (newActivityDetails, result) => {
     console.log(newActivityDetails);
     sql.query("INSERT INTO ActivityDetails SET ?", newActivityDetails, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create ActivityDetails: ", { id: res.insertId, ...newActivityDetails });
          result(null, { id: res.insertId, ...newActivityDetails });
     });
};

ActivityDetails.findByIdRiceCropInformation = (id, result) => {
     sql.query(`SELECT * FROM ActivityDetails WHERE RiceCropInformation_id like '${id}'`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.length) {
               result(null, res);
               return;
          }
          // not found ActivityDetails with the id
          result({ kind: "not_found" }, null);
     });
};

ActivityDetails.getAll = (otherActivities_id, result) => {
     let query = "SELECT * FROM ActivityDetails";
     if (otherActivities_id) {
          query += ` WHERE OtherActivities_id LIKE '%${otherActivities_id}%'`;
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

ActivityDetails.updateById = (riceCropInformation_id, otherActivities_id, times, activityDetails, result) => {
     sql.query(
          "UPDATE ActivityDetails SET Employee_id = ?, ActivityDetails_startDate = ?, ActivityDetails_endDate = ?, ActivityDetails_temperature = ?, ActivityDetails_humidity = ?, ActivityDetails_precipitation = ?, DevelopmentStage_id = ? WHERE (RiceCropInformation_id = ? And OtherActivities_id= ? and ActivityDetails_times = ?)",
          [activityDetails.Employee_id, activityDetails.ActivityDetails_startDate, activityDetails.ActivityDetails_endDate, activityDetails.ActivityDetails_temperature, activityDetails.ActivityDetails_humidity, activityDetails.ActivityDetails_precipitation, activityDetails.DevelopmentStage_id, riceCropInformation_id, otherActivities_id, times],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(null, err);
                    return;
               }
               if (res.affectedRows == 0) {
                    // not found ActivityDetails with the id
                    result({ kind: "not_found" }, null);
                    return;
               }
               result(null, { riceCropInformation_id: riceCropInformation_id, ...activityDetails });

          }
     );
};

ActivityDetails.remove = (riceCropInformation_id, otherActivities_id, times, result) => {
     sql.query(`DELETE FROM ActivityDetails WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND OtherActivities_id LIKE '${otherActivities_id}' AND ActivityDetails_times LIKE '${times}')`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          if (res.affectedRows == 0) {
               // not found ActivityDetails with the id
               result({ kind: "not_found" }, null);
               return;
          }
          console.log("deleted ActivityDetails with id: ", riceCropInformation_id);
          result(null, res);
     });
};

ActivityDetails.removeAll = result => {
     sql.query("DELETE FROM ActivityDetails", (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(null, err);
               return;
          }
          console.log(`deleted ${res.affectedRows} ActivityDetails`);
          result(null, res);
     });
};

module.exports = ActivityDetails;