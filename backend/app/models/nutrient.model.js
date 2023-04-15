const sql = require("./db");

const Nutrient = function(nutrient){
    this.Nutrient_id = nutrient.Nutrient_id;
    this.Nutrient_name = nutrient.Nutrient_name;
};

Nutrient.create = (newNutrient, result) => {
    sql.query("INSERT INTO Nutrient SET ?", newNutrient, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Nutrient: ", { id: res.insertId, ...newNutrient});
        result(null, { id: res.insertId, ...newNutrient });
    });
};

Nutrient.findById = (id, result) => {
    sql.query(`SELECT * FROM Nutrient WHERE Nutrient_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found Nutrient: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found Nutrient with the id
        result({ kind: "not_found" }, null);
    });
};

Nutrient.getAll = (name, result) => {
    let query = "SELECT * FROM Nutrient";
    if (name) {
        query += ` WHERE Nutrient_name LIKE '%${name}%'`;
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

Nutrient.updateById = (id, nutrient, result) => {
    sql.query(
        "UPDATE Nutrient SET Nutrient_name = ? WHERE Nutrient_id = ?",
        [nutrient.Nutrient_name, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Nutrient with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Nutrient: ", { id: id, ...nutrient });
            result(null, { id: id, ...nutrient });
            
        }
    );
};

Nutrient.remove = (id, result) => {
    sql.query("DELETE FROM Nutrient WHERE Nutrient_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Nutrient with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Nutrient with id: ", id);
        result(null, res);
    });
};

Nutrient.removeAll = result => {
    sql.query("DELETE FROM Nutrient", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Nutrient`);
        result(null, res);
    });
};

module.exports = Nutrient;