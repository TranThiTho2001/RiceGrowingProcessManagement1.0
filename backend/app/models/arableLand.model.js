const sql = require("./db");

const ArableLand = function(arableLand){
    this.ArableLand_id = arableLand.ArableLand_id;
    this.ArableLand_location = arableLand.ArableLand_location;
    this.Soil_id = arableLand.Soil_id;
    this.ArableLand_area = arableLand.ArableLand_area;
    this.ArableLand_owner = arableLand.ArableLand_owner;
    this.ArableLand_latitude = arableLand.ArableLand_latitude;
    this.ArableLand_longitude = arableLand.ArableLand_longitude;
    this.Province_id = arableLand.Province_id;
};

ArableLand.create = (newArableLand, result) => {
    sql.query("INSERT INTO ArableLand SET ?", newArableLand, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create ArableLand: ", { id: res.insertId, ...newArableLand});
        result(null, { id: res.insertId, ...newArableLand });
    });
};

ArableLand.findById = (id, result) => {
    sql.query(`(SELECT * FROM ArableLand WHERE ArableLand_id like '${id}') JOIN Soil where Soil.Soil_id = ArableLand.Soil_id `, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found ArableLand with the id
        result({ kind: "not_found" }, null);
    });
};

ArableLand.getAll = (name, result) => {
    let query = "SELECT * FROM ArableLand JOIN Soil on Soil.Soil_id = ArableLand.Soil_id Join Province on Province.Province_id = ArableLand.Province_id";
    if (name) {
        query += ` WHERE ArableLand_owner LIKE '%${name}%'`; 
    }
    query += " ORDER BY ArableLand.ArableLand_id"
    // query += " (JOIN Soil one Soil.Soil_id = ArableLand.Soil_id)"
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

ArableLand.updateById = (id, arableLand, result) => {
    sql.query(
        "UPDATE ArableLand SET ArableLand_location = ?, Soil_id = ?, ArableLand_area = ?, ArableLand_owner = ?, ArableLand_latitude = ?, ArableLand_longitude = ?, Province_id = ? WHERE ArableLand_id = ?",
        [arableLand.ArableLand_location, arableLand.Soil_id, arableLand.ArableLand_area, arableLand.ArableLand_owner,arableLand.ArableLand_latitude, arableLand.ArableLand_longitude, arableLand.Province_id, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found ArableLand with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated ArableLand: ", { id: id, ...arableLand });
            result(null, { id: id, ...arableLand });
            
        }
    );
};

ArableLand.remove = (id, result) => {
    sql.query("DELETE FROM ArableLand WHERE ArableLand_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found ArableLand with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted ArableLand with id: ", id);
        result(null, res);
    });
};

ArableLand.removeAll = result => {
    sql.query("DELETE FROM ArableLand", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} ArableLand`);
        result(null, res);
    });
};

module.exports = ArableLand;