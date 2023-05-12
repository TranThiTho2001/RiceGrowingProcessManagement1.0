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
        result(null, { id: res.insertId, ...newMonitor });
    });
};

//find by RiceCropInformation_id
Monitor.findByIdRiceCropInformation = (id, result) => {
    sql.query(`SELECT * FROM Monitor` +
    " JOIN Ricecropinformation ON Ricecropinformation.RiceCropInformation_id = Monitor.RiceCropInformation_id"+
    ` Join Employee on Employee.Employee_id = Monitor.Employee_id` +
    ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
    ` JOIN ArableLand on ArableLand.ArableLand_id = RiceCropInformation.ArableLand_id` +
    ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id` + 
    ` JOIN Province on Province.Province_id = ArableLand.Province_id `+
    ` WHERE Ricecropinformation.RiceCropInformation_id like '${id}' Order by Employee.Role_id`, (err, res) => {
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

// Retrieve all Monitor from the database (with condition).
Monitor.getAll = (employee_id, result) => {
    let query = "SELECT * FROM Monitor" + 
    ` JOIN Ricecropinformation ON Ricecropinformation.RiceCropInformation_id = Monitor.RiceCropInformation_id`+
    ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
    ` JOIN ArableLand on ArableLand.ArableLand_id = RiceCropInformation.ArableLand_id` +
    ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id` + 
    ` JOIN Province on Province.Province_id = ArableLand.Province_id `+
    ` JOIN Employee on Employee.Employee_id = Monitor.Employee_id `;
    if (employee_id) {
        query += ` WHERE Employee.Employee_id LIKE '%${employee_id}%'`;
    }
    query += " ORDER BY Ricecropinformation.RiceCropInformation_id"
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

//find by RiceCropInformation_id and Empoyee_name
Monitor.findByName = (name,id, result) => {
    let query = "SELECT * FROM Monitor" + 
    ` JOIN Ricecropinformation ON Ricecropinformation.RiceCropInformation_id = Monitor.RiceCropInformation_id` +
    ` JOIN Seed on Seed.Seed_id = RiceCropInformation.Seed_id` +
    ` JOIN ArableLand on ArableLand.ArableLand_id = RiceCropInformation.ArableLand_id` +
    ` JOIN Crop on Crop.Crop_id = RiceCropInformation.Crop_id` + 
    ` JOIN Province on Province.Province_id = ArableLand.Province_id `+
    ` JOIN Employee on Employee.Employee_id = Monitor.Employee_id `;
    if (name) {
        query += ` WHERE Employee.Employee_name LIKE '%${name}%' AND Monitor.RiceCropInformation_id like '${id}'`;
    }
    query += " ORDER BY Monitor.Employee_id"
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

// Update a Monitor identified by the id in the request
Monitor.updateById = (id, monitor, result) => {
    sql.query(
        "UPDATE Monitor SET Employee_id = ? WHERE RiceCropInformation_id = ?",
        [monitor.employee_id, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
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

// Delete a Monitor with the specified id in the request
Monitor.remove = (riceCropInformation_id, employee_id, result) => {
    sql.query(`DELETE FROM Monitor WHERE (RiceCropInformation_id LIKE '${riceCropInformation_id}' AND Employee_id LIKE '${employee_id}')`,(err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
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
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Monitor`);
        result(null, res);
    });
};

module.exports = Monitor;