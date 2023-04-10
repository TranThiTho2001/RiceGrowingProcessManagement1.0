const sql = require("./db");

const OtherActivities = function(otherActivities){
    this.OtherActivities_id = otherActivities.OtherActivities_id;
    this.OtherActivities_name = otherActivities.OtherActivities_name;
};

OtherActivities.create = (newOtherActivities, result) => {
    sql.query("INSERT INTO OtherActivities SET ?", newOtherActivities, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create OtherActivities: ", { id: res.insertId, ...newOtherActivities});
        result(null, { id: res.insertId, ...newOtherActivities });
    });
};

OtherActivities.findById = (id, result) => {
    sql.query(`SELECT * FROM OtherActivities WHERE OtherActivities_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found OtherActivities with the id
        result({ kind: "not_found" }, null);
    });
};

OtherActivities.getAll = (name, result) => {
    let query = "SELECT * FROM OtherActivities";
    if (name) {
        query += ` WHERE OtherActivities_name LIKE '%${name}%'`;
    }
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(res)
        result(null, res);
    });
};

OtherActivities.updateById = (id, otherActivities, result) => {
    sql.query(
        "UPDATE OtherActivities SET OtherActivities_name = ? WHERE OtherActivities_id = ?",
        [otherActivities.OtherActivities_name, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                // not found OtherActivities with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated OtherActivities: ", { id: id, ...otherActivities });
            result(null, { id: id, ...otherActivities });
            
        }
    );
};

OtherActivities.remove = (id, result) => {
    sql.query("DELETE FROM OtherActivities WHERE OtherActivities_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        if (res.affectedRows == 0) {
            // not found OtherActivities with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted OtherActivities with id: ", id);
        result(null, res);
    });
};

OtherActivities.removeAll = result => {
    sql.query("DELETE FROM OtherActivities", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} OtherActivities`);
        result(null, res);
    });
};

module.exports = OtherActivities;