const sql = require("./db");

const Epidemic = function (epidemic) {
    this.Epidemic_id = epidemic.Epidemic_id;
    this.Epidemic_name = epidemic.Epidemic_name;
    this.Epidemic_indication = epidemic.Epidemic_indication;
    this.Epidemic_timeOfDevelopment = epidemic.Epidemic_timeOfDevelopment;
    this.Epidemic_developmentEnvironment = epidemic.Epidemic_developmentEnvironment;
    this.Epidemic_Harm = epidemic.Epidemic_Harm;
    this.EpidemicClassification_id = epidemic.EpidemicClassification_id;
    this.Epidemic_image = epidemic.Epidemic_image;
};

Epidemic.create = (newEpidemic, result) => {
    sql.query("INSERT INTO Epidemic SET ?", newEpidemic, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Epidemic: ", { id: res.insertId, ...newEpidemic });
        result(null, { id: res.insertId, ...newEpidemic });
    });
};

//find by Epidemic_id
Epidemic.findById = (id, result) => {
    sql.query(`SELECT * FROM Epidemic JOIN Epidemicclassification ON Epidemic.EpidemicClassification_id = Epidemicsclassification.EpidemicClassification_id WHERE Epidemic_id like '${id}'  ORDER BY Epidemic_id`, (err, res) => {
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

// Retrieve all Epidemic from the database (with condition).
Epidemic.getAll = (name, result) => {
    let query = "SELECT * FROM Epidemic JOIN Epidemicclassification ON Epidemic.EpidemicClassification_id = EpidemicClassification.EpidemicClassification_id";
    if (name) {
        query += ` WHERE Epidemic_name LIKE '%${name}%'`;
    }
    query += ` ORDER BY Epidemic_id`
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

// Update a Epidemic identified by the id in the request
Epidemic.updateById = (id, epidemic, result) => {
    sql.query(
        "UPDATE Epidemic SET Epidemic_name = ?, Epidemic_indication = ?, Epidemic_timeOfDevelopment = ?, Epidemic_developmentEnvironment = ?, Epidemic_Harm = ?, EpidemicClassification_id = ?, Epidemic_image = ? WHERE Epidemic_id = ?",
        [epidemic.Epidemic_name, epidemic.Epidemic_indication, epidemic.Epidemic_timeOfDevelopment, epidemic.Epidemic_developmentEnvironment, epidemic.Epidemic_Harm, epidemic.EpidemicClassification_id, epidemic.Epidemic_image, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
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

// Update a Epidemic identified by the id in the request
Epidemic.remove = (id, result) => {
    sql.query("DELETE FROM Epidemic WHERE Epidemic_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
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

module.exports = Epidemic;