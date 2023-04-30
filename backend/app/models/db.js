const mysql = require("mysql2")


const connection = mysql.createConnection({
     host: 'localhost',
     user: 'root',
     password: '12345678',
     database: 'ricegrowingprocessmanagementdatabase'
});

connection.connect( error =>{
     if(error) throw error;
     console.log("Connect to database ok!!!!");
});

module.exports = connection;