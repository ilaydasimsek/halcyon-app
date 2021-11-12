import express, { Application } from "express";
import { initFirebaseAdmin } from "./util/firebaseUtils";
import log from "loglevel";
import config from "config";
import router from "./routes";

initFirebaseAdmin();
const env = process.env.NODE_ENV || "development";
log.setLevel(env === "development" ? "debug" : "info", true);

const app: Application = express();
app.use(express.json());

const PORT = config.get("server.port") || 3000;
app.use("/api", router);
app.listen(PORT, (): void => {
  log.info(`Server Running here https://localhost:${PORT}`);
});
