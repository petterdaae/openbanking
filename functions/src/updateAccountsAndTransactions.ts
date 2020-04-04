import SbankenClient from "./sbanken";
import createAccountsClient from "./accounts";
import createTransactionsClient from "./transactions";
import * as functions from "firebase-functions";
import Dependencies from "./dependencies";

async function updateAccounts(deps: Dependencies, uid: string) {
  const snapshot = await deps.firestore.collection('users').doc(uid).get();
  const id = snapshot.get('sbanken_clientid');
  const secret = snapshot.get('sbanken_clientsecret');
  const nationalId = snapshot.get('nationalid');

  const sbankenClient = new SbankenClient(id, secret, nationalId);
  const accounts = await sbankenClient.getAccounts();

  const accountsClient = createAccountsClient(deps, uid);
  await accountsClient.updateAccounts(accounts);
}

async function updateTransactions(deps: Dependencies, uid: string) {
  const snapshot = await deps.firestore.collection('users').doc(uid).get();
  const id = snapshot.get('sbanken_clientid');
  const secret = snapshot.get('sbanken_clientsecret');
  const nationalId = snapshot.get('nationalid');
  const sbankenClient = new SbankenClient(id, secret, nationalId);
  const transactionsClient = createTransactionsClient(deps, uid);

  const accounts = await sbankenClient.getAccounts();
  for (const account of accounts) {
    const transactions = await sbankenClient.getTransactions(account.accountId);
    await transactionsClient.updateTransactions(transactions);

  }
}

export default (deps: Dependencies) => functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError('permission-denied', "Authentication failed");
  }
  await updateAccounts(deps, context.auth.uid);
  await updateTransactions(deps, context.auth.uid);
  return {
    message: "Successfully updated accounts and transactions"
  };
});
