const sql = require("./db");

const Employee = function(employee){
    this.Employee_name = employee.Employee_name;
    this.Employee_major = employee.Employee_major;
    this.Employee_sex = employee.Employee_sex;
    this.Employee_id = employee.Employee_id;
    this.Role_id = employee.Role_id;
    this.Employee_password = employee.Employee_password;
    this.Employee_phoneNumber = employee.Employee_phoneNumber;
    this.Employee_address = employee.Employee_address;
    this.Employee_email = employee.Employee_email;
    this.Employee_birthDate = employee.Employee_birthDate;
    this.Employee_identityCardNumber = employee.Employee_identityCardNumber

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
    sql.query(`SELECT * FROM employee WHERE Employee_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
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
    query += " JOIN Role where Role.Role_id = Employee.Role_id";
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

Employee.updateById = (id, employee, result) => {
    sql.query(
        "UPDATE Employee SET Employee_name = ?, Employee_sex = ?, Employee_major = ?, Role_id =?, Employee_identityCardNumber = ?,  Employee_phoneNumber = ?,  Employee_address = ?, Employee_email = ?, Employee_birthDate = ?  WHERE Employee_id = ?",
        [employee.Employee_name, employee.Employee_sex, employee.Employee_major,employee.Role_id, employee.Employee_identityCardNumber, employee.Employee_phoneNumber, employee.Employee_address, employee.Employee_email, employee.Employee_birthDate, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err,null );
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
            result(err,null);
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
            result(err,null );
            return;
        }
        console.log(`deleted ${res.affectedRows} Employee`);
        result(null, res);
    });
};

Employee.changePassword = (id, password, result) => {
    sql.query(
        "UPDATE Employee SET Employee_password = ? WHERE Employee_id = ?",
        [password, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(null, err);
                return;
            }
            if (res.affectedRows == 0) {
                result({ kind: "not_found" }, null);
                return;
            }
            result(null, { Employee_id: id });
        }
    );
};


module.exports = Employee;