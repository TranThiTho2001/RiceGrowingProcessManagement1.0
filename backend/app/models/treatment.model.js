const sql = require("./db");

const Treatment = function(treatment){
    this.Pesticide_id = treatment.Pesticide_id;
    this.Epidemic_id = treatment.Epidemic_id;
};

Treatment.create = (newTreatment, result) => {
    sql.query("INSERT INTO Treatment SET ?", newTreatment, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create: ", { id: res.insertId, ...newTreatment });
        result(null, { id: res.insertId, ...newTreatment });
    });
};

Treatment.findByPesticideid = (id, result) => {
    sql.query(`SELECT * FROM Treatment` +
    ` Join Pesticide on Pesticide.Pesticide_id = Treatment.Pesticide_id` +
    ` JOIN Epidemic on Epidemic.Epidemic_id = Treatment.Epidemic_id` +
     ` WHERE Treatment.Pesticide_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res);
            return;
        }
        // not found Monitor with the id
        result({ kind: "not_found" }, null);
    });
};

Treatment.findByPesticideName = (name, result) => {
     sql.query(`SELECT * FROM Treatment` +
     ` Join Pesticide on Pesticide.Pesticide_id = Treatment.Pesticide_id` +
     ` JOIN Epidemic on Epidemic.Epidemic_id = Treatment.Epidemic_id` +
      ` WHERE Pesticide.Pesticide_name like '%${name}%'`, (err, res) => {
         if (err) {
             console.log("error: ", err);
             result(err, null);
             return;
         }
         if (res.length) {
             result(null, res);
             return;
         }
         // not found Monitor with the id
         result({ kind: "not_found" }, null);
     });
 };

Treatment.getAll = (employee_id, result) => {
    let query = "SELECT * FROM Treatment" + 
    ` Join Pesticide on Pesticide.Pesticide_id = Treatment.Pesticide_id` +
    ` JOIN Epidemic on Epidemic.Epidemic_id = Treatment.Epidemic_id`;
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};
Treatment.findEpidemicId = (id, result) => {
    let query = "SELECT * FROM Treatment" + 
    ` Join Pesticide on Pesticide.Pesticide_id = Treatment.Pesticide_id` +
    ` JOIN Epidemic on Epidemic.Epidemic_id = Treatment.Epidemic_id`;
    if (id) {
        query += ` WHERE Epidemic.Epidemic_id LIKE '${id}'`;
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

Treatment.findByEpidemicName = (name, result) => {
     let query = "SELECT * FROM Treatment" + 
     ` Join Pesticide on Pesticide.Pesticide_id = Treatment.Pesticide_id` +
     ` JOIN Epidemic on Epidemic.Epidemic_id = Treatment.Epidemic_id`;
     if (name) {
         query += ` WHERE Epidemic.Epidemic_name LIKE '%${name}%'`;
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

// Treatment.updateById = (id, monitor, result) => {
//     sql.query(
//         "UPDATE Treatment SET Employee_id = ? WHERE RiceCropInformation_id = ?",
//         [monitor.employee_id, id],
//         (err, res) => {
//             if (err) {
//                 console.log("error: ", err);
//                 result(err, null);
//                 return;
//             }
//             if (res.affectedRows == 0) {
//                 // not found Monitor with the id
//                 result({ kind: "not_found" }, null);
//                 return;
//             }
//             console.log("updated Monitor: ", { id: id, ...monitor });
//             result(null, { id: id, ...monitor });
            
//         }
//     );
// };

Treatment.remove = (Pesticide_id, Epidemic_id, result) => {
    sql.query(`DELETE FROM Treatment WHERE (Treatment.Pesticide_id LIKE '${Pesticide_id}' AND Epidemic_id LIKE '${Epidemic_id}')`,(err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Treatment with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Treatment with id: ",  Pesticide_id, Epidemic_id);
        result(null, res);
    });
};

Treatment.removeAll = result => {
    sql.query("DELETE FROM Monitor", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Monitor`);
        result(null, res);
    });
};

module.exports = Treatment;