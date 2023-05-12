const sql = require("./db");

const Province = function (province) {
     this.Province_id = province.Province_id;
     this.Province_name = province.Province_name;
}

Province.create = (newProvince, result) => {
     sql.query("INSERT INTO Province SET ?", newProvince, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log("create Province: ", { id: res.insertId, ...newProvince });
          result(null, { id: res.insertId, ...newProvince });
     });
};


Province.getAll = (name, result) => {
     let query = `SELECT * FROM  Province`
     if (name) {
          query += ` WHERE Province.Province_name LIKE '%${name}%'`;
     }
     sql.query(query, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result( err,null);
               return;
          }
          result(null, res);
     });
};

Province.updateById = (id, province, result) => {
     sql.query(
          "UPDATE Province SET Province_name = ? WHERE Province_id = ?",
          [province.Province_name, id],
          (err, res) => {
               if (err) {
                    console.log("error: ", err);
                    result(err, null);
                    return;
               }
               if (res.affectedRows == 0) {
                    // not found Province with the id
                    result({ kind: "not_found" }, null);
                    return;
               }
               console.log("updated Province: ", { id: id, ...province });
               result(null, { id: id, ...province });
          }
     );
};

Province.remove = (id, result) => {
     sql.query("DELETE FROM Province WHERE Province_id = ?", id, (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          if (res.affectedRows == 0) {
               // not found Province with the id
               result({ kind: "not_found" }, null);
               return;
          }
          console.log("deleted Province with id: ", id);
          result(null, res);
     });
};

Province.removeAll = result => {
     sql.query("DELETE FROM Province", (err, res) => {
          if (err) {
               console.log("error: ", err);
               result(err, null);
               return;
          }
          console.log(`deleted ${res.affectedRows} Province`);
          result(null, res);
     });
};

module.exports = Province;