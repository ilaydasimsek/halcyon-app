import express, { Application } from "express";
import { initFirebaseAdmin } from "./util/firebase";
const app: Application = express();
const PORT = process.env.PORT || 8000;

initFirebaseAdmin();

app.listen(PORT, (): void => {
  console.log(`Server Running here https://localhost:${PORT}`);
});
