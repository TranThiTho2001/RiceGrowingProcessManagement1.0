const sql = require("./db");

const Seed = function(seed){
    this.Seed_id = seed.Seed_id;
    this.Seed_name = seed.Seed_name;
    this.Seed_characteristic = seed.Seed_characteristic;
    this.Seed_supplier = seed.Seed_supplier;
};

Seed.create = (newSeed, result) => {
    sql.query("INSERT INTO Seed SET ?", newSeed, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Seed: ", { id: res.insertId, ...newSeed});
        result(null, { id: res.insertId, ...newSeed });
    });
};

Seed.findById = (id, result) => {
    sql.query(`SELECT * FROM Seed WHERE Seed_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found Seed with the id
        result({ kind: "not_found" }, null);
    });
};

Seed.getAll = (name, result) => {
    let query = "SELECT * FROM Seed";
    if (name) {
        query += ` WHERE Seed_name LIKE '%${name}%'`;
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

Seed.updateById = (id, seed, result) => {
    sql.query(
        "UPDATE Seed SET Seed_name = ?, Seed_characteristic = ?, Seed_supplier = ? WHERE Seed_id = ?",
        [seed.Seed_name, seed.Seed_characteristic, seed.Seed_supplier, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err,null );
                return;
            }
            if (res.affectedRows == 0) {
                // not found Seed with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Seed: ", { id: id, ...seed });
            result(null, { id: id, ...seed });
            
        }
    );
};

Seed.remove = (id, result) => {
    sql.query("DELETE FROM Seed WHERE Seed_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err,null );
            return;
        }
        if (res.affectedRows == 0) {
            // not found Seed with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Seed with id: ", id);
        result(null, res);
    });
};

Seed.removeAll = result => {
    sql.query("DELETE FROM Seed", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Seed`);
        result(null, res);
    });
};

module.exports = Seed;