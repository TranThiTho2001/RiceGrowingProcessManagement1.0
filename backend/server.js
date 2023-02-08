const express = require("express");
const cors = require("cors");
const config = require("./app/config");
const { BadRequestError } = require("./app/helpers/errors");

const setupEmployeeRoutes = require("./app/routes/employee.routes");


 

const app = express();

app.use(cors({ origin: config.app.origins }));

app.use(express.json());

// set routes

//

app.subscribe(express.urlencoded({ extended: true }));
const mysql = require("mysql2")
// handle 404 response

 
 // define error-handling middleware last, after other app.use() and routes calls
 app.use((err, req, res, next) => {
     console.log(err);
     res.status(err.statusCode || 500).json({
         message: err.message || "Internal Server Error",
     });
 });
 

app.get("/", (req, res) => {
     res.json({message: "welcome to rice growing process management!!!"});
});
// app.use(express.static("uploads"));
setupEmployeeRoutes(app);
const PORT = config.app.port;
app.listen(PORT, () => {
     console.log(`server is running on port ${PORT}.`);
});