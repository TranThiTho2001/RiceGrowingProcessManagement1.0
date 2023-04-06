const sql = require("./db");

const Images = function(newImage){
    this.Image_id = newImage.Image_id;
    this.Image_link = newImage.Image_link;
    this.Image_date = newImage.Image_date;
    this.RiceCropInformation_id = newImage.RiceCropInformation_id;
    this.Image_location = newImage.Image_location;
};

Images.create = (newImage, result) => {
    sql.query("INSERT INTO Images SET ?", newImage, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        console.log("created Image: ", { id: res.insertId, ...newImage });
        result(null, { id: res.insertId, ...newImage });
    });
};

Images.findById = (id, result) => {
    sql.query(`SELECT * FROM Images WHERE Image_id like '${id}'`, (err, res) => {
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

Images.getAll = (name, result) => {
    let query = "SELECT * FROM Images  JOIN RiceCropInformation on  RiceCropInformation.RiceCropInformation_id= Images.RiceCropInformation_id";
    if(name) {
        query += ` WHERE Images.RiceCropInformation_id LIKE '%${name}%'`;
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
Images.updateById = (id, image, result) => {
     sql.query(
         "UPDATE Images SET Image_date = ?, Image_link = ?, Image_location = ?,RiceCropInformation_id = ?  WHERE Image_id = ?",
         [image.Image_date, image.Image_link, image.Image_location, image.RiceCropInformation_id, id],
         (err, res) => {
             if (err) {
                 console.log("error: ", err);
                 result(null, err);
                 return;
             }
             if (res.affectedRows == 0) {
                 // not found Fertilizer with the id
                 result({ kind: "not_found" }, null);
                 return;
             }
             console.log("updated Fertilizer: ", { id: id, ...image });
             result(null, { id: id, ...image });
             
         }
     );
 };

Images.remove = (id, result) => {
    sql.query("DELETE FROM Images WHERE Image_id = ?", id, (err, res) => {
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
        console.log("deleted Image with id: ", id);
        result(null, res);
    });
};




module.exports = Images;