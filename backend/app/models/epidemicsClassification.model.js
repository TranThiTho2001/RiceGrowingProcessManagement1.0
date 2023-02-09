const sql = require("./db");

const EpidemicsClassification = function(epidemicsClassification){
    this.EpidemicsClassification_id = epidemicsClassification.id;
    this.EpidemicsClassification_name = epidemicsClassification.name;
};

EpidemicsClassification.create = (newEpidemicsClassification, result) => {
    sql.query("INSERT INTO EpidemicsClassification SET ?", newEpidemicsClassification, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create EpidemicsClassification: ", { id: res.insertId, ...newEpidemicsClassification});
        result(null, { id: res.insertId, ...newEpidemicsClassification });
    });
};

EpidemicsClassification.findById = (id, result) => {
    sql.query(`SELECT * FROM EpidemicsClassification WHERE EpidemicsClassification_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found EpidemicsClassification: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found EpidemicsClassification with the id
        result({ kind: "not_found" }, null);
    });
};

EpidemicsClassification.getAll = (name, result) => {
    let query = "SELECT * FROM EpidemicsClassification";
    if (name) {
        query += ` WHERE EpidemicsClassification_name LIKE '%${name}%'`;
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


module.exports = EpidemicsClassification;