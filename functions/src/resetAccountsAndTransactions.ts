import Dependencies from "./dependencies";
import * as functions from "firebase-functions";

export default (deps: Dependencies) => functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError('permission-denied', "Authentication failed");
  }

  const accounts = await deps
    .firestore
    .collection('users')
    .doc(context.auth.uid)
    .collection('accounts')
    .get();

  await Promise.all(accounts.docs.map(async doc => await doc.ref.delete()));

  const transactions = await deps
    .firestore
    .collection('users')
    .doc(context.auth.uid)
    .collection('transactions')
    .get();

  await Promise.all(transactions.docs.map(async doc => await doc.ref.delete()));

  return {
    message: "All accounts and transactions removed"
  };
});
