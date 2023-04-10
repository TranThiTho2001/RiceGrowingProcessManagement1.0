const sql = require("./db");

const EpidemicClassification = function(epidemicClassification){
    this.EpidemicClassification_id = epidemicClassification.EpidemicClassification_id;
    this.EpidemicClassification_name = epidemicClassification.EpidemicClassification_name;
};

EpidemicClassification.create = (newEpidemicClassification, result) => {
    sql.query("INSERT INTO EpidemicClassification SET ?", newEpidemicClassification, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create EpidemicClassification: ", { id: res.insertId, ...newEpidemicClassification});
        result(null, { id: res.insertId, ...newEpidemicClassification });
    });
};

EpidemicClassification.findById = (id, result) => {
    sql.query(`SELECT * FROM EpidemicClassification WHERE EpidemicClassification_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found EpidemicClassification: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found EpidemicClassification with the id
        result({ kind: "not_found" }, null);
    });
};

EpidemicClassification.getAll = (name, result) => {
    let query = "SELECT * FROM EpidemicClassification";
    if (name) {
        query += ` WHERE EpidemicClassification_name LIKE '%${name}%'`;
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


module.exports = EpidemicClassification;