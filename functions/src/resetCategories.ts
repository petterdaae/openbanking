import Dependencies from "./dependencies";
import * as functions from "firebase-functions";

export default (deps: Dependencies) => functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('permission-denied', "Authentication failed");
  }

  return {
    message: "yay"
  };
});
