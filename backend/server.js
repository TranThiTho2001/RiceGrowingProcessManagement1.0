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
const setUpImagesRoutes = require("./app/routes/images.router");
const setupNutrientRoutes = require("./app/routes/nutrient.routes");
const setupContainRoutes = require("./app/routes/contain.routes");
const setUpProvinceRoutes = require("./app/routes/province.routes");
const setupMonitorRoutes = require("./app/routes/Monitor.routes");
const setupTreatmentRoutes = require("./app/routes/treatment.routes");
const setupEpidemicRoutes = require("./app/routes/epidemic.routes");
const setupEmployeeRoutes = require("./app/routes/employee.routes");
const setupPesticideRoutes = require("./app/routes/pesticide.routes");
const setupFertilizerRoutes = require("./app/routes/fertilizer.routes");
const setupArableLandRoutes = require("./app/routes/arableLand.routes");
const setupPedictionRoutes = require("./app/routes/prediction.routes");
const setupEpidemicTimesRoutes = require("./app/routes/epidemicTimes.routes");
const setupSprayingTimesRoutes = require("./app/routes/sprayingTimes.routes");
const setupFertilizerTimesRoutes = require("./app/routes/fertilizerTimes.routes");
const setupActivityDetailsRoutes = require("./app/routes/activityDetails.routes");
const setupOtherActivitiesRoutes = require("./app/routes/otherActivities.routes");
const setupDevelopmentStageRoutes = require("./app/routes/DevelopmentStage.routes");
const setupRiceCropInformationRoutes = require("./app/routes/riceCropInformation.routes");
const setupEpidemicsClassificationRoutes = require("./app/routes/epidemicClassification.routes");

const app = express();
const bodyParser= require('body-parser')
app.use(cors());

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
setUpImagesRoutes(app);
setupMonitorRoutes(app);
setupTreatmentRoutes(app);
setupEpidemicRoutes(app);
setupPedictionRoutes(app);
setUpProvinceRoutes(app);
setupEmployeeRoutes(app);
setupPesticideRoutes(app);
setupContainRoutes(app);
setupNutrientRoutes(app);
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



// define error-handling middleware last, after other app.use() and routes calls
app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.statusCode || 500).json({
        message: err.message || "Internal Server Error",
    });
});

// app.get('/', (req, res) => {
   
//         const { spawn } = require('child_process');
//         const pyProg = spawn('python', ['./predictionModel/LinearRegression.py']);
    
//         pyProg.stdout.on('data', function(data) {
    
//             console.log(data.toString());
//             res.write(data);
//             res.end('end');
//         });
// })


// backup and restore
const cron = require('node-cron');
const moment = require('moment');
const fs = require('fs');
const spawn = require('child_process').spawn;
const  mysqldump =require('mysqldump');
cron.schedule('0 15 10 * * MON', () => {
    const fileName = "ricegrowingprocessmanagementdatabase"+`${moment().format('YYYY_MM_DD')}.sql`
mysqldump({
    connection: {
        host: 'localhost',
        user: 'root',
        password: '12345678',
        database: 'ricegrowingprocessmanagementdatabase',
    },
    dumpToFile: `../backup/${fileName}`,
});
});
// Lap lich sao luu du lieu
// cron.schedule('0 5 10 * * *', () => {
//     const fs = require('fs')
//     const spawn = require('child_process').spawn
//     const dumpFileName = `${Math.round(Date.now() / 1000)}.dump.sql`
    
//     const writeStream = fs.createWriteStream(dumpFileName)
    
//     const dump = spawn('mysqldump', [
//         '-u',
//         'root',
//         '-p12345678',
//         'ricegrowingprocessmanagementdatabase',
//     ])
    
//     dump
//         .stdout
//         .pipe(writeStream)
//         .on('finish', function () {
//             console.log('Completed')
//         })
//         .on('error', function (err) {
//             console.log(err)
//         })
// })


const PORT = config.app.port;
app.listen(PORT, () => {
    console.log(`server is running on port ${PORT}.`);
});