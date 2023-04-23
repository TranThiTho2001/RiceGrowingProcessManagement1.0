const sql = require("./db");

const Algorithm = function(algorithm){
    this.Algorithm_id = algorithm.Algorithm_id;
    this.Algorithm_name = algorithm.Algorithm_name;
};

Algorithm.create = (newAlgorithm, result) => {
    sql.query("INSERT INTO Algorithm SET ?", newAlgorithm, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Algorithm: ", { id: res.insertId, ...newAlgorithm});
        result(null, { id: res.insertId, ...newAlgorithm });
    });
};

Algorithm.findById = (id, result) => {
    sql.query(`SELECT * FROM Algorithm WHERE Algorithm_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found Algorithm: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found Algorithm with the id
        result({ kind: "not_found" }, null);
    });
};

Algorithm.getAll = (name, result) => {
    let query = "SELECT * FROM Algorithm";
    if (name) {
        query += ` WHERE Algorithm_name LIKE '%${name}%'`;
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

Algorithm.updateById = (id, algorithm, result) => {
    sql.query(
        "UPDATE Algorithm SET Algorithm_name = ? WHERE Algorithm_id = ?",
        [algorithm.Algorithm_name, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Algorithm with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Algorithm: ", { id: id, ...algorithm });
            result(null, { id: id, ...algorithm });
            
        }
    );
};

Algorithm.remove = (id, result) => {
    sql.query("DELETE FROM Algorithm WHERE Algorithm_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Algorithm with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Algorithm with id: ", id);
        result(null, res);
    });
};

Algorithm.removeAll = result => {
    sql.query("DELETE FROM Algorithm", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Algorithm`);
        result(null, res);
    });
};

module.exports = Algorithm;