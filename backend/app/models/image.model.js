const sql = require("./db");

const Image = function(newImage){
    this.id = newImage.id;
    this.Image_link = newImage.Image_link;

};

Image.create = (newImage, result) => {
    sql.query("INSERT INTO Image SET ?", newImage, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("created Image: ", { id: res.insertId, ...newImage });
        result(null, { id: res.insertId, ...newImage });
    });
};
Image.findById = (id, result) => {
    sql.query(`SELECT * FROM Image WHERE Image_id like '${id}'`, (err, res) => {
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


module.exports = Image;