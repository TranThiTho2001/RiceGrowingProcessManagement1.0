const sql = require("./db");

const ArableLand = function(arableLand){
    this.ArableLand_id = arableLand.id;
    this.ArableLand_location = arableLand.location;
    this.Soil_id = arableLand.soilId;
    this.ArableLand_area = arableLand.area;
    this.ArableLand_owner = arableLand.owner;
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
    sql.query(`SELECT * FROM ArableLand WHERE ArableLand_id like '${id}'`, (err, res) => {
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
    let query = "SELECT * FROM ArableLand";
    if (name) {
        query += ` WHERE ArableLand_name LIKE '%${name}%'`;
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

ArableLand.updateById = (id, arableLand, result) => {
    sql.query(
        "UPDATE ArableLand SET ArableLand_location = ?, Soil_id = ?, ArableLand_area = ?, ArableLand_owner = ? WHERE ArableLand_id = ?",
        [arableLand.location, arableLand.soilId, arableLand.area, arableLand.owner, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
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
            result(null, err);
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
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} ArableLand`);
        result(null, res);
    });
};

module.exports = ArableLand;