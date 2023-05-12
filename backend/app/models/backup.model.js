const sql = require("./db");

const Backup = function (backup) {
    this.Backup_date = backup.Backup_date;
    this.Backup_link = backup.Backup_link;
    this.Backup_id = '';
};

Backup.create = (newBackup, result) => {
    sql.query("INSERT INTO Backup SET ?", newBackup, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("create Backup: ", { id: res.insertId, ...newBackup });
        result(null, { id: res.insertId, ...newBackup });
    });
};

// Retrieve all Backup from the database (with condition).
Backup.getAll = (name, result) => {
    let query = "SELECT * FROM Backup Order By Backup_id DESC";
    sql.query(query, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

// Delete a Backup with the specified id in the request
Backup.remove = (id, result) => {
    sql.query(`DELETE FROM Backup WHERE Backup_id LIKE '${id}'`, (err, res) => {
        console.log(id)
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            console.log("r")
            // not found Backup with the id
            result({ kind: "not_found" }, null);
            return;
        }
        console.log("deleted Backup with id: ", id);
        result(null, res);
    });
};

module.exports = Backup;