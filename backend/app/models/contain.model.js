const sql = require("./db");

const Contain = function(contain){
    this.Fertilizer_id = contain.Fertilizer_id;
    this.Nutrient_id = contain.Nutrient_id;
    this.Contain_percent= contain.Contain_percent;
};

Contain.create = (newContain, result) => {
    sql.query("INSERT INTO Contain SET ?", newContain, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Contain: ", { id: res.insertId, ...newContain});
        result(null, { id: res.insertId, ...newContain });
    });
};

Contain.findbyFertilizerId = (fertilizer_id, result) => {
    sql.query(`SELECT * FROM Contain WHERE Fertilizer_id like '${fertilizer_id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found Contain: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found Contain with the id
        result({ kind: "not_found" }, null);
    });
};

Contain.findbyNutrientID = (nutrient_id, result) => {
     sql.query(`SELECT * FROM Contain WHERE Nutrient_id like '${nutrient_id}'`, (err, res) => {
         if (err) {
             console.log("error: ", err);
             result(err, null);
             return;
         }
         if (res.length) {
             console.log("found Contain: ", res[0]);
             result(null, res[0]);
             return;
         }
         // not found Contain with the id
         result({ kind: "not_found" }, null);
     });
 };

 Contain.findbyFertilizerAndNutrient = (fertilizer_id, nutrient_id, result) => {
     sql.query(`SELECT * FROM Contain WHERE  Nutrient_id like '${nutrient_id}' And Fertilizer_id like '${fertilizer_id}' `, (err, res) => {
         if (err) {
             console.log("error: ", err);
             result(err, null);
             return;
         }
         if (res.length) {
             console.log("found Contain: ", res[0]);
             result(null, res[0]);
             return;
         }
         // not found Contain with the id
         result({ kind: "not_found" }, null);
     });
 };


Contain.getAll = (name, result) => {
    let query = "SELECT * FROM Contain";
    if (name) {
        query += ` WHERE Nutrient_id LIKE '%${name}%'`;
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

Contain.updateById = (id, contain, result) => {
    sql.query(
        "UPDATE Contain SET Nutrient_id = ? WHERE Fertilizer_id = ?",
        [contain.Nutrient_id, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Contain with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Contain: ", { id: id, ...contain });
            result(null, { id: id, ...contain });
            
        }
    );
};

Contain.remove = (fertilizer_id, nutrient_id, result) => {
    sql.query("DELETE FROM Contain WHERE Fertilizer_id = ? And NNutrient_id = ?", fertilizer_id, nutrient_id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Contain with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Contain with id: ", id);
        result(null, res);
    });
};

Contain.removeAll = result => {
    sql.query("DELETE FROM Contain", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Contain`);
        result(null, res);
    });
};

module.exports = Contain;