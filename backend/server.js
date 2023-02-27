const express = require("express");
const cors = require("cors");
const config = require("./app/config");
const { BadRequestError } = require("./app/helpers/errors");
const multer = require('multer');

const setupRoleRoutes = require("./app/routes/role.routes");
const setupCropRoutes = require("./app/routes/crop.routes");
const setupSeedRoutes = require("./app/routes/seed.routes");
const setupSoilRoutes = require("./app/routes/soil.routes");
const setUpImageRoutes = require("./app/routes/image.router");
const setupMonitorRoutes = require("./app/routes/Monitor.routes");
const setupEpidemicRoutes = require("./app/routes/epidemic.routes");
const setupEmployeeRoutes = require("./app/routes/employee.routes");
const setupPesticideRoutes = require("./app/routes/pesticide.routes");
const setupFertilizerRoutes = require("./app/routes/fertilizer.routes");
const setupArableLandRoutes = require("./app/routes/arableLand.routes");
const setupEpidemicTimesRoutes = require("./app/routes/epidemicTimes.routes");
const setupSprayingTimesRoutes = require("./app/routes/sprayingTimes.routes");
const setupFertilizerTimesRoutes = require("./app/routes/fertilizerTimes.routes");
const setupActivityDetailsRoutes = require("./app/routes/activityDetails.routes");
const setupOtherActivitiesRoutes = require("./app/routes/otherActivities.routes");
const setupDevelopmentStageRoutes = require("./app/routes/DevelopmentStage.routes");
const setupRiceCropInformationRoutes = require("./app/routes/riceCropInformation.routes");
const setupEpidemicsClassificationRoutes = require("./app/routes/epidemicsClassification.routes");

const app = express();
const bodyParser= require('body-parser')
app.use(cors({ origin: config.app.origins }));

app.use(express.json());
app.use(express.urlencoded({
 extended: true,
 })
);

app.use(bodyParser.urlencoded({extended: true}))
// set routes
// app.use(express.static("uploads"));

setupRoleRoutes(app);
setupCropRoutes(app);
setupSeedRoutes(app);
setupSoilRoutes(app);
setUpImageRoutes(app);
setupMonitorRoutes(app);
setupEpidemicRoutes(app);
setupEmployeeRoutes(app);
setupPesticideRoutes(app);
setupFertilizerRoutes(app);
setupArableLandRoutes(app);
setupEpidemicTimesRoutes(app);
setupSprayingTimesRoutes(app);
setupFertilizerTimesRoutes(app);
setupActivityDetailsRoutes(app);
setupOtherActivitiesRoutes(app);
setupDevelopmentStageRoutes(app);
setupRiceCropInformationRoutes(app);
setupEpidemicsClassificationRoutes(app);


// SET STORAGE
// var storage = multer.diskStorage({
//     destination: function (req, file, cb) {
//       cb(null, '/uploads')
//     },
//     filename: function (req, file, cb) {
//       cb(null, file.fieldname + '-' + Date.now())
//     }
//   })

//   var upload = multer({ storage: storage })

//   app.post('/api/image', upload.single('image'), (req, res, next) => {
//     const file = req.file
//     console.log(file);
//     if (!file) {
//       const error = new Error('Please upload a file')
//       error.httpStatusCode = 400
//       return next(error)
//     }
//     res.send(file)
//   })
// define error-handling middleware last, after other app.use() and routes calls
app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.statusCode || 500).json({
        message: err.message || "Internal Server Error",
    });
});

app.get("/", (req, res) => {
    res.json({ message: "welcome to rice growing process management!!!" });
});

const PORT = config.app.port;
app.listen(PORT, () => {
    console.log(`server is running on port ${PORT}.`);
});