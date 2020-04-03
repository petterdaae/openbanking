import SbankenClient from "./sbanken";
import createAccountsClient from "./accounts";
import createTransactionsClient from "./transactions";
import * as functions from "firebase-functions";
import Dependencies from "./dependencies";

async function updateAccounts(deps: Dependencies) {
  const snapshot = await deps.firestore.collection('users').doc(deps.uid).get();
  const id = snapshot.get('sbanken_clientid');
  const secret = snapshot.get('sbanken_clientsecret');
  const nationalId = snapshot.get('nationalid');

  const sbankenClient = new SbankenClient(id, secret, nationalId);
  const accounts = await sbankenClient.getAccounts();

  const accountsClient = createAccountsClient(deps);
  await accountsClient.updateAccounts(accounts);
}

async function updateTransactions(deps: Dependencies) {
  const snapshot = await deps.firestore.collection('users').doc(deps.uid).get();
  const id = snapshot.get('sbanken_clientid');
  const secret = snapshot.get('sbanken_clientsecret');
  const nationalId = snapshot.get('nationalid');
  const sbankenClient = new SbankenClient(id, secret, nationalId);
  const transactionsClient = createTransactionsClient(deps);

  const accounts = await sbankenClient.getAccounts();
  for (const account of accounts) {
    const transactions = await sbankenClient.getTransactions(account.accountId);
    await transactionsClient.updateTransactions(transactions);

  }
}

export default (deps: Dependencies) => functions.https.onRequest(async (request, response) => {
  if (1 === 1) return;
  try {
    await updateAccounts(deps);
    await updateTransactions(deps);
  } catch(e) {
    response.status(500).send({
      message: "Internal server error"
    });
  }
  response.send({
    message: "Successfully updated accounts and transactions"
  });
});

