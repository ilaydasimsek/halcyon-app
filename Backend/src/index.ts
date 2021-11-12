import express, { Application } from "express";
import { initFirebaseAdmin } from "./util/firebase";
import config from "config";

const app: Application = express();
const PORT = config.get("server.port") || 3000;
initFirebaseAdmin();

app.listen(PORT, (): void => {
  console.log(`Server Running here https://localhost:${PORT}`);
});
