const sql = require("./db");

const Role = function(role){
    this.Role_id = role.Role_id;
    this.Role_name = role.Role_name;
};

Role.create = (newRole, result) => {
    sql.query("INSERT INTO Role SET ?", newRole, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create role: ", { id: res.insertId, ...newRole});
        result(null, { id: res.insertId, ...newRole });
    });
};
Role.findById = (id, result) => {
    sql.query(`SELECT * FROM role WHERE Role_id like '${id}'`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        // not found role with the id
        result({ kind: "not_found" }, null);
    });
};

Role.getAll = (name, result) => {
    let query = "SELECT * FROM role";
    if (name) {
        query += ` WHERE role_name LIKE '%${name}%'`;
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

Role.updateById = (id, role, result) => {
    sql.query(
        "UPDATE role SET Role_name = ? WHERE Role_id = ?",
        [role.Role_name, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                // not found role with the id
                result({ kind: "not_found" }, null);
                return;
            }
            console.log("updated role: ", { id: id, ...role });
            result(null, { id: id, ...role });
            
        }
    );
};
Role.remove = (id, result) => {
    sql.query("DELETE FROM role WHERE role_id = ?", id, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            // not found role with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted role with id: ", id);
        result(null, res);
    });
};

Role.removeAll = result => {
    sql.query("DELETE FROM role", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log(`deleted ${res.affectedRows} Role`);
        result(null, res);
    });
};

module.exports = Role;