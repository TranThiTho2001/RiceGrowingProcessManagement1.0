const sql = require("./db");

const RiceCropInformation = function (riceCropInformation) {
     this.RiceCropInformation_id = riceCropInformation.RiceCropInformation_id;
     this.Crop_id = riceCropInformation.Crop_id;
     this.Seed_id = riceCropInformation.Seed_id;
     this.ArableLand_id = riceCropInformation.ArableLand_id;
     this.RiceCropInformation_name = riceCropInformation.RiceCropInformation_name;
     this.RiceCropInformation_yield = riceCropInformation.RiceCropInformation_yield;
     this.RiceCropInformation_sowingDate = riceCropInformation.RiceCropInformation_sowingDate;
     this.RiceCropInformation_harvestDate = riceCropInformation.RiceCropInformation_harvestDate;
}

RiceCropInformation.create = (newRiceCropInformation, result) => {
     sql.query("INSERT INTO RiceCropInformation SET ?", newRiceCropInformation, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create RiceCropInformation: ", { id: res.insertId, ...newRiceCropInformation });
          result(null, { id: res.insertId, ...newRiceCropInformation });
     });
};

RiceCropInformation.findById = (id, result) => {
     sql.query(`SELECT * FROM RiceCropInformation` + 
     ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
     ` JOIN ArableLand on ArableLand.ArableLand_id= RiceCropInformation.ArableLand_id` +
     ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id` + 
     ` WHERE RiceCropInformation_id like '${id}'`, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.length) {
               result(null, res[0]);
               return;
          }
          // not found RiceCropInformation with the id
          result({ kind: "not_found" }, null);
     });
};

RiceCropInformation.getAll = (name, result) => {
     let query = "SELECT * FROM RiceCropInformation " +
     ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
     ` JOIN ArableLand on ArableLand.ArableLand_id= RiceCropInformation.ArableLand_id` +
     ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id`;
     if (name) {
          query += ` WHERE RiceCropInformation_name LIKE '%${name}%'`;
     }
query += ' order by RiceCropInformation_id';
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          result(null, res);
     });
};

RiceCropInformation.getByemployeeAndRiceCrop = (name,id, result) => {
     let query = "SELECT * FROM RiceCropInformation"+
     ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
     ` JOIN ArableLand on ArableLand.ArableLand_id= RiceCropInformation.ArableLand_id` +
     ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id`+
     ` JOIN Monitor on Monitor.RiceCropInformation_id = RiceCropInformation.RiceCropInformation_id`
     if (name) {
          query += ` WHERE RiceCropInformation_name LIKE '%${name}%' and Employee_id LIKE '%${id}%'`;
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

RiceCropInformation.findByArableLand = (name,id, result) => {
     let query = "SELECT * FROM RiceCropInformation "+
     ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
     ` JOIN ArableLand on ArableLand.ArableLand_id= RiceCropInformation.ArableLand_id` +
     ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id`
     if (name) {
          query += ` WHERE  LIKE ArableLand.ArableLand_name '%${name}%' or ArableLand.ArableLand_id LIKE '%${name}%'`;
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

RiceCropInformation.findRiceCropHarvested = (result) => {
     let query = "SELECT * FROM RiceCropInformation "+
     ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
     ` JOIN ArableLand on ArableLand.ArableLand_id= RiceCropInformation.ArableLand_id` +
     ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id `+
     ` Where RiceCropInformation_harvestDate Is Not NULL`
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          result(null, res);
     });
};

RiceCropInformation.updateById = (id, riceCropInformation, result) => {
     sql.query(
          "UPDATE RiceCropInformation SET Seed_id = ?, RiceCropInformation_name = ?, RiceCropInformation_sowingDate = ?, RiceCropInformation_harvestDate = ?, RiceCropInformation_yield = ?, ArableLand_id = ?, Crop_id = ? WHERE RiceCropInformation_id = ?",
          [riceCropInformation.Seed_id, riceCropInformation.RiceCropInformation_name, riceCropInformation.RiceCropInformation_sowingDate, riceCropInformation.RiceCropInformation_harvestDate, riceCropInformation.RiceCropInformation_yield, riceCropInformation.ArableLand_id, riceCropInformation.Crop_id, id],
          (err, res) => {
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
               console.log("updated RiceCropInformation: ", { id: id, ...riceCropInformation });
               result(null, { id: id, ...riceCropInformation });

          }
     );
};

RiceCropInformation.remove = (id, result) => {
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

RiceCropInformation.removeAll = result => {
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

module.exports = RiceCropInformation;