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
    sql.query(`SELECT * FROM Contain Join nutrient on nutrient.Nutrient_id = Contain.Nutrient_id WHERE Fertilizer_id like '${fertilizer_id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

Contain.findbyNutrientID = (nutrient_id, result) => {
     sql.query(`SELECT * FROM Contain  Join nutrient on nutrient.Nutrient_id = Contain.Nutrient_id WHERE Nutrient_id like '${nutrient_id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
     });
 };

 Contain.findbyFertilizerAndNutrient = (fertilizer_id, nutrient_id, result) => {
     sql.query(`SELECT * FROM Contain  Join nutrient on nutrient.Nutrient_id = Contain.Nutrient_id WHERE  Nutrient_id like '${nutrient_id}' And Fertilizer_id like '${fertilizer_id}' `, (err, res) => {
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
    let query = "SELECT * FROM Contain  Join nutrient on nutrient.Nutrient_id = Contain.Nutrient_id ";
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

Contain.updateById = (fertilizer_id, nutrient_id,contain, result) => {
    console.log(fertilizer_id, nutrient_id);
    sql.query(
        "UPDATE Contain SET  Contain_percent = ? WHERE (Nutrient_id = ? And Fertilizer_id = ?)",
        [ contain.Contain_percent, nutrient_id, fertilizer_id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Contain with the id
                console.log("no");
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Contain: ", { id: fertilizer_id, ...contain });
            result(null, { id: fertilizer_id, ...contain });
            
        }
    );
};

Contain.remove = (fertilizer_id, nutrient_id, result) => {
    // console.log(fertilizer_id, nutrient_id)
    sql.query(`DELETE FROM Contain WHERE (Fertilizer_id LIKE '${fertilizer_id}' And Nutrient_id LIKE '${nutrient_id}' )`,  (err, res) => {
        console.log(fertilizer_id, nutrient_id)
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            console.log("r")
            // not found Contain with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Contain with id: ", fertilizer_id);
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