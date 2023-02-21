const sql = require("./db");

const Monitor = function(monitor){
    this.Employee_id = monitor.Employee_id;
    this.RiceCropInformation_id = monitor.RiceCropInformation_id;
};

Monitor.create = (newMonitor, result) => {
    sql.query("INSERT INTO Monitor SET ?", newMonitor, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Monitor: ", { id: res.insertId, ...newMonitor});
        result(null, { id: res.insertId, ...newMonitor });
    });
};

Monitor.findByIdRiceCropInformation = (id, result) => {
    sql.query(`SELECT * FROM Monitor` +
    ` Join Employee on Employee.Employee_id = Monitor.Employee_id` +
     ` WHERE RiceCropInformation_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found Monitor: ", res);
            result(null, res);
            return;
        }
        // not found Monitor with the id
        result({ kind: "not_found" }, null);
    });
};

Monitor.getAll = (employee_id, result) => {
    let query = "SELECT * FROM Monitor JOIN Ricecropinformation ON Ricecropinformation.RiceCropInformation_id = Monitor.RiceCropInformation_id";
    if (employee_id) {
        query += ` WHERE Employee_id LIKE '%${employee_id}%'`;
    }
    query += " ORDER BY Ricecropinformation.RiceCropInformation_id"
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

Monitor.updateById = (id, monitor, result) => {
    sql.query(
        "UPDATE Monitor SET Employee_id = ? WHERE RiceCropInformation_id = ?",
        [monitor.employee_id, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                // not found Monitor with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated Monitor: ", { id: id, ...monitor });
            result(null, { id: id, ...monitor });
            
        }
    );
};

Monitor.remove = (riceCropInformation_id, employee_id, result) => {
    sql.query(`DELETE FROM Monitor WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Employee_id LIKE '${employee_id}')`,(err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        if (res.affectedRows == 0) {
            // not found Monitor with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Monitor with id: ",  employee_id, riceCropInformation_id);
        result(null, res);
    });
};

Monitor.removeAll = result => {
    sql.query("DELETE FROM Monitor", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} Monitor`);
        result(null, res);
    });
};

module.exports = Monitor;