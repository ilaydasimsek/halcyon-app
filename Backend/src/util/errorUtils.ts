import { FirebaseAuthError } from "firebase-admin/lib/utils/error";

export type CustomErrorReason = "verification-email-not-sent";
export const throwCustomError = (reason: CustomErrorReason) => {
  throw { code: reason };
};

export const throwCustomFirebaseError = (error: FirebaseAuthError) => {
  throw { code: error.code };
};
