const sql = require("./db");

const Pesticide = function(pesticide){
    this.Pesticide_id = pesticide.Pesticide_id;
    this.Pesticide_name = pesticide.Pesticide_name;
    this.Pesticide_supplier = pesticide.Pesticide_supplier;
    this.Pesticide_component = pesticide.Pesticide_component;
    this.Pesticide_directionsForUse = pesticide.Pesticide_directionsForUse;
    this.Pesticide_uses = pesticide.Pesticide_uses;
    this.Pesticide_image = pesticide.Pesticide_image;
};

Pesticide.create = (newPesticide, result) => {
    sql.query("INSERT INTO Pesticide SET ?", newPesticide, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Pesticide: ", { id: res.insertId, ...newPesticide});
        result(null, { id: res.insertId, ...newPesticide });
    });
};

//find by Pesticide_id
Pesticide.findById = (id, result) => {
    sql.query(`SELECT * FROM Pesticide WHERE Pesticide_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found Pesticide with the id
        result({ kind: "not_found" }, null);
    });
};

// Retrieve all Pesticide from the database (with condition).
Pesticide.getAll = (name, result) => {
    let query = "SELECT * FROM Pesticide";
    if (name) {
        query += ` WHERE Pesticide_name LIKE '%${name}%'`;
    }
    query += ` ORDER BY Pesticide_id`;
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

// Update a Pesticide identified by the id in the request
Pesticide.updateById = (id, pesticide, result) => {
    sql.query(
        "UPDATE Pesticide SET Pesticide_name = ?, Pesticide_supplier = ?, Pesticide_component = ?, Pesticide_directionsForUse = ?, Pesticide_uses = ?, Pesticide_image = ? WHERE Pesticide_id = ?",
        [pesticide.Pesticide_name, pesticide.Pesticide_supplier, pesticide.Pesticide_component, pesticide.Pesticide_directionsForUse, pesticide.Pesticide_uses, pesticide.Pesticide_image, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Pesticide with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Pesticide: ", { id: id, ...pesticide });
            result(null, { id: id, ...pesticide });           
        }
    );
};

// Delete a Pesticide with the specified id in the request
Pesticide.remove = (id, result) => {
    sql.query("DELETE FROM Pesticide WHERE Pesticide_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Pesticide with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Pesticide with id: ", id);
        result(null, res);
    });
};

Pesticide.removeAll = result => {
    sql.query("DELETE FROM Pesticide", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Pesticide`);
        result(null, res);
    });
};

module.exports = Pesticide;