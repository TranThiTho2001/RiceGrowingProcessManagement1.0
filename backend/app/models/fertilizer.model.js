const sql = require("./db");

const Fertilizer = function(fertilizer){
    this.Fertilizer_id = fertilizer.Fertilizer_id;
    this.Fertilizer_name = fertilizer.Fertilizer_name;
    this.Fertilizer_supplier = fertilizer.Fertilizer_supplier;
    this.Fertilizer_uses = fertilizer.Fertilizer_uses;
    this.Fertilizer_directionsForUse = fertilizer.Fertilizer_directionsForUse;
    this.Fertilizer_image = fertilizer.Fertilizer_image;
};

Fertilizer.create = (newFertilizer, result) => {
    sql.query("INSERT INTO Fertilizer SET ?", newFertilizer, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Fertilizer: ", { id: res.insertId, ...newFertilizer});
        result(null, { id: res.insertId, ...newFertilizer });
    });
};

Fertilizer.findById = (id, result) => {
    sql.query(`SELECT * FROM Fertilizer WHERE Fertilizer_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found Fertilizer with the id
        result({ kind: "not_found" }, null);
    });
};

Fertilizer.getAll = (name, result) => {
    let query = "SELECT * FROM Fertilizer";
    if (name) {
        query += ` WHERE Fertilizer_name LIKE '%${name}%'`;
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

Fertilizer.updateById = (id, fertilizer, result) => {
    sql.query(
        "UPDATE Fertilizer SET Fertilizer_name = ?, Fertilizer_supplier = ?, Fertilizer_uses = ?, Fertilizer_directionsForUse = ? , Fertilizer_image =? WHERE Fertilizer_id = ?",
        [fertilizer.Fertilizer_name, fertilizer.Fertilizer_supplier, fertilizer.Fertilizer_uses, fertilizer.Fertilizer_directionsForUse, fertilizer.Fertilizer_image,  id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Fertilizer with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Fertilizer: ", { id: id, ...fertilizer });
            result(null, { id: id, ...fertilizer });
            
        }
    );
};

Fertilizer.remove = (id, result) => {
    sql.query("DELETE FROM Fertilizer WHERE Fertilizer_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Fertilizer with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Fertilizer with id: ", id);
        result(null, res);
    });
};

Fertilizer.removeAll = result => {
    sql.query("DELETE FROM Fertilizer", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Fertilizer`);
        result(null, res);
    });
};

module.exports = Fertilizer;