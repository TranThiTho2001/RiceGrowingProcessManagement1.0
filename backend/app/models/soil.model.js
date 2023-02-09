const sql = require("./db");

const Soil = function(soil){
    this.Soil_id = soil.id;
    this.Soil_name = soil.name;
};

Soil.create = (newSoil, result) => {
    sql.query("INSERT INTO Soil SET ?", newSoil, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Soil: ", { id: res.insertId, ...newSoil});
        result(null, { id: res.insertId, ...newSoil });
    });
};

Soil.findById = (id, result) => {
    sql.query(`SELECT * FROM Soil WHERE Soil_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found Soil with the id
        result({ kind: "not_found" }, null);
    });
};

Soil.getAll = (name, result) => {
    let query = "SELECT * FROM Soil";
    if (name) {
        query += ` WHERE Soil_name LIKE '%${name}%'`;
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

Soil.updateById = (id, soil, result) => {
    sql.query(
        "UPDATE Soil SET Soil_name = ? WHERE Soil_id = ?",
        [soil.name, soil.characteristic, soil.supplier, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Soil with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Soil: ", { id: id, ...soil });
            result(null, { id: id, ...soil });
            
        }
    );
};

Soil.remove = (id, result) => {
    sql.query("DELETE FROM Soil WHERE Soil_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Soil with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Soil with id: ", id);
        result(null, res);
    });
};

Soil.removeAll = result => {
    sql.query("DELETE FROM Soil", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} Soil`);
        result(null, res);
    });
};

module.exports = Soil;