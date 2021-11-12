import firebaseAdmin from "firebase-admin";
import {
  createUserWithEmailAndPassword,
  getAuth,
  sendEmailVerification,
} from "@firebase/auth";
import { FirebaseUserDTO } from "../types/firebase-user.types";
import { initializeApp } from "firebase/app";
import log from "loglevel";

export const initFirebaseAdmin = () => {
  try {
    const adminCredentials = require("../../config/credentials/firebase-admin-credentials.json");
    const firebaseCredentials = require("../../config/credentials/firebase-credentials.json");

    firebaseAdmin.initializeApp({
      credential: firebaseAdmin.credential.cert(adminCredentials),
    });
    initializeApp(firebaseCredentials);
  } catch (e) {
    log.error(`Could not initialized firebase: ${e}`);
    process.exit(1);
  }
};

export const signUp = (user: FirebaseUserDTO) => {
  return createUserWithEmailAndPassword(
    getAuth(),
    user.email,
    user.password
  ).then((userCredentials) =>
    sendEmailVerification(userCredentials.user).catch((e) =>
      log.error(`Could not send verification email: ${e}`)
    )
  );
};
