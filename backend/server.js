const express = require("express");
const cors = require("cors");
const config = require("./app/config");
const { BadRequestError } = require("./app/helpers/errors");


const setupRoleRoutes = require("./app/routes/role.routes");
const setupCropRoutes = require("./app/routes/crop.routes");
const setupSeedRoutes = require("./app/routes/seed.routes");
const setupSoilRoutes = require("./app/routes/soil.routes");
const setupEpidemicRoutes = require("./app/routes/epidemic.routes");
const setupEmployeeRoutes = require("./app/routes/employee.routes");
const setupPesticideRoutes = require("./app/routes/pesticide.routes");
const setupFertilizerRoutes = require("./app/routes/fertilizer.routes");
const setupArableLandRoutes = require("./app/routes/arableLand.routes");
const setupOtherActivitiesRoutes = require("./app/routes/otherActivities.routes");
const setupRiceCropInformationRoutes = require("./app/routes/riceCropInformation.routes");
const setupEpidemicsClassificationRoutes = require("./app/routes/epidemicsClassification.routes");

const app = express();

app.use(cors({ origin: config.app.origins }));
app.use(express.json());
app.subscribe(express.urlencoded({ extended: true }));

// set routes
// app.use(express.static("uploads"));

setupRoleRoutes(app);
setupCropRoutes(app);
setupSeedRoutes(app);
setupSoilRoutes(app);
setupEpidemicRoutes(app);
setupEmployeeRoutes(app);
setupPesticideRoutes(app);
setupFertilizerRoutes(app);
setupArableLandRoutes(app);
setupOtherActivitiesRoutes(app);
setupRiceCropInformationRoutes(app);
setupEpidemicsClassificationRoutes(app);

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