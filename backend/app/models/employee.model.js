const sql = require("./db");

const Employee = function(employee){
    this.Employee_name = employee.name;
    this.Employee_major = employee.major;
    this.Employee_sex = employee.sex;
};

Employee.create = (newEmployee, result) => {
    sql.query("INSERT INTO Employee SET ?", newEmployee, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("created Employee: ", { id: res.insertId, ...newEmployee });
        result(null, { id: res.insertId, ...newEmployee });
    });
};
Employee.findById = (id, result) => {
    sql.query(`SELECT * FROM employee WHERE Employee_id like '%${id}%'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            console.log("found Employee: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found todo with the id
        result({ kind: "not_found" }, null);
    });
};
Employee.getAll = (name, result) => {
    let query = "SELECT * FROM Employee";
    if (name) {
        query += ` WHERE Employee_name LIKE '%${name}%'`;
    }
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log("Employee: ", res[0].Employee_name);
        result(null, res);
    });
};

Employee.updateById = (id, employee, result) => {
    sql.query(
        "UPDATE todo SET Employee_name = ?, Employee_sex = ?, Employee_major = ? WHERE Employee_id = ?",
        [employee.name, employee.sex, employee.major, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                // not found employee with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated employee: ", { id: id, ...employee });
            result(null, { id: id, ...employee });
            
        }
    );
};
Employee.remove = (id, result) => {
    sql.query("DELETE FROM Employee WHERE Employee_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        if (res.affectedRows == 0) {
            // not found todo with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Employee with id: ", id);
        result(null, res);
    });
};
Employee.removeAll = result => {
    sql.query("DELETE FROM Employee", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        console.log(`deleted ${res.affectedRows} Employee`);
        result(null, res);
    });
};
module.exports = Employee;