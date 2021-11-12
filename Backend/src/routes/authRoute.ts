import express from "express";
import { login, signUp } from "../util/firebaseUtils";

const router = express.Router();

router.post("/signup", (request, response) => {
  const { email, password } = request.body || {};

  if (!email || !password) {
    response.sendStatus(400);
    return;
  }
  signUp({ email, password })
    .then(() => response.sendStatus(200))
    .catch((e) => {
      response.status(500);
      response.send(e);
    });
});

router.post("/login", (request, response) => {
  const { email, password } = request.body || {};
  if (!email || !password) {
    response.sendStatus(400);
    return;
  }
  login({ email, password })
    .then(() => response.sendStatus(200))
    .catch((e) => {
      response.status(500);
      response.send(e);
    });
});

export default router;
