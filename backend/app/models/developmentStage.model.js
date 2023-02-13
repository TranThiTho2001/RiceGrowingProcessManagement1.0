const sql = require("./db");

const DevelopmentStage = function(developmentStage){
    this.DevelopmentStage_id = developmentStage.DevelopmentStage_id;
    this.DevelopmentStage_name = developmentStage.DevelopmentStage_name;

};

DevelopmentStage.create = (newDevelopmentStage, result) => {
    sql.query("INSERT INTO DevelopmentStage SET ?", newDevelopmentStage, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create DevelopmentStage: ", { id: res.insertId, ...newDevelopmentStage});
        result(null, { id: res.insertId, ...newDevelopmentStage });
    });
};

DevelopmentStage.findById = (id, result) => {
    sql.query(`SELECT * FROM DevelopmentStage WHERE DevelopmentStage_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found DevelopmentStage with the id
        result({ kind: "not_found" }, null);
    });
};

DevelopmentStage.getAll = (name, result) => {
    let query = "SELECT * FROM DevelopmentStage";
    if (name) {
        query += ` WHERE DevelopmentStage_name LIKE '%${name}%'`;
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

DevelopmentStage.updateById = (id, developmentStage, result) => {
    sql.query(
        "UPDATE DevelopmentStage SET DevelopmentStage_name = ? WHERE DevelopmentStage_id = ?",
        [developmentStage.DevelopmentStage_name, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                // not found DevelopmentStage with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated DevelopmentStage: ", { id: id, ...developmentStage });
            result(null, { id: id, ...developmentStage });
            
        }
    );
};

DevelopmentStage.remove = (id, result) => {
    sql.query("DELETE FROM DevelopmentStage WHERE DevelopmentStage_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        if (res.affectedRows == 0) {
            // not found DevelopmentStage with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted DevelopmentStage with id: ", id);
        result(null, res);
    });
};

DevelopmentStage.removeAll = result => {
    sql.query("DELETE FROM DevelopmentStage", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} DevelopmentStage`);
        result(null, res);
    });
};

module.exports = DevelopmentStage;