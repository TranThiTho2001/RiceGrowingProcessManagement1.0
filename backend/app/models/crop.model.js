const sql = require("./db");

const Crop = function(crop){
    this.Crop_id = crop.Crop_id;
    this.Crop_name = crop.Crop_name;
};

Crop.create = (newCrop, result) => {
    sql.query("INSERT INTO Crop SET ?", newCrop, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Crop: ", { id: res.insertId, ...newCrop});
        result(null, { id: res.insertId, ...newCrop });
    });
};

// find by Crop_id
Crop.findById = (id, result) => {
    sql.query(`SELECT * FROM Crop WHERE Crop_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found Crop: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found Crop with the id
        result({ kind: "not_found" }, null);
    });
};

// Retrieve all Crop from the database (with condition).
Crop.getAll = (name, result) => {
    let query = "SELECT * FROM Crop";
    if (name) {
        query += ` WHERE Crop_name LIKE '%${name}%'`;
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

// Update a Crop identified by the id in the request
Crop.updateById = (id, crop, result) => {
    sql.query(
        "UPDATE Crop SET Crop_name = ? WHERE Crop_id = ?",
        [crop.Crop_name, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Crop with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Crop: ", { id: id, ...crop });
            result(null, { id: id, ...crop });
        }
    );
};

// Delete a Crop with the specified id in the request
Crop.remove = (id, result) => {
    sql.query("DELETE FROM Crop WHERE Crop_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Crop with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Crop with id: ", id);
        result(null, res);
    });
};

Crop.removeAll = result => {
    sql.query("DELETE FROM Crop", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Crop`);
        result(null, res);
    });
};

module.exports = Crop;