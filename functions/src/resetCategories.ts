import Dependencies from "./dependencies";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export default (deps: Dependencies) => functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError('permission-denied', "Authentication failed");
  }

  const transactions = await deps.firestore.collection('users').doc(context.auth.uid).collection('transactions').get();
  await Promise.all(transactions.docs.map(async transaction => {
    // @ts-ignore
    await deps.firestore.collection('users').doc(context.auth.uid).collection('transactions').doc(transaction.id).update({
      'categoryId': admin.firestore.FieldValue.delete()
    });
  }));

  return {
    message: "All categorization removed"
  };
});
