const express = require("express");
const cors = require("cors");
const config = require("./app/config");

const app = express();

app.use(cors({ origin: config.app.origins }));

app.use(express.json());

app.subscribe(express.urlencoded({ extended: true }));

app.get("/", (req, res) => {
     res.json({message: "welcome to rice growing process management!!!"});
});

const PORT = config.app.port;
app.listen(PORT, () => {
     console.log(`server is running on port ${PORT}.`);
});