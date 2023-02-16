const sql = require("./db");

const Epidemic = function(epidemic){
    this.Epidemic_id = epidemic.Epidemic_id;
    this.Epidemic_name = epidemic.Epidemic_name;
    this.Epidemic_indication = epidemic.Epidemic_indication;
    this.Epidemic_timeOfDevelopment = epidemic.Epidemic_timeOfDevelopment;
    this.Epidemic_developmentEnvironment = epidemic.Epidemic_developmentEnvironment;
    this.Epidemic_Harm = epidemic.Epidemic_Harm;
    this.EpidemicsClassification_id = epidemic.EpidemicsClassification_id;
};

Epidemic.create = (newEpidemic, result) => {
    sql.query("INSERT INTO Epidemic SET ?", newEpidemic, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Epidemic: ", { id: res.insertId, ...newEpidemic});
        result(null, { id: res.insertId, ...newEpidemic });
    });
};

Epidemic.findById = (id, result) => {
    sql.query(`SELECT * FROM Epidemic WHERE Epidemic_id like '${id}' JOIN Epidemicsclassification where Epidemic.EpidemicsClassification_id = Epidemicsclassification.EpidemicsClassification_id`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found Epidemic with the id
        result({ kind: "not_found" }, null);
    });
};

Epidemic.getAll = (name, result) => {
    let query = "SELECT * FROM Epidemic";
    if (name) {
        query += ` WHERE Epidemic_name LIKE '%${name}%'`;
    }
    query += " JOIN Epidemicsclassification where Epidemic.EpidemicsClassification_id = Epidemicsclassification.EpidemicsClassification_id"
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

Epidemic.updateById = (id, epidemic, result) => {
    sql.query(
        "UPDATE Epidemic SET Epidemic_name = ?, Epidemic_indication = ?, Epidemic_timeOfDevelopment = ?, Epidemic_developmentEnvironment = ?, Epidemic_Harm = ?, EpidemicsClassification_id = ?  WHERE Epidemic_id = ?",
        [epidemic.Epidemic_name, epidemic.Epidemic_indication, epidemic.Epidemic_timeOfDevelopment, epidemic.Epidemic_developmentEnvironment,epidemic.Epidemic_Harm, epidemic.EpidemicsClassification_id, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Epidemic with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Epidemic: ", { id: id, ...epidemic });
            result(null, { id: id, ...epidemic });
            
        }
    );
};

Epidemic.remove = (id, result) => {
    sql.query("DELETE FROM Epidemic WHERE Epidemic_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Epidemic with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Epidemic with id: ", id);
        result(null, res);
    });
};

Epidemic.removeAll = result => {
    sql.query("DELETE FROM Epidemic", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} Epidemic`);
        result(null, res);
    });
};

module.exports = Epidemic;