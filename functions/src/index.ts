import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import SbankenClient from './sbanken';
import Dependencies from './dependencies';
import createAccountsClient from './accounts';
import createTransactionsClient from './transactions';

admin.initializeApp();
const db = admin.firestore();
const uid = 'EKDRNcDbDgUYbdGyFFUevSLBrW33';

const deps: Dependencies = {
    firestore: db,
    uid: uid
}

async function updateAccounts() {
    const snapshot = await db.collection('users').doc(uid).get();
    const id = snapshot.get('sbanken_clientid');
    const secret = snapshot.get('sbanken_clientsecret');
    const nationalId = snapshot.get('nationalid');

    let sbankenClient = new SbankenClient(id, secret, nationalId);
    let accounts = await sbankenClient.getAccounts();

    let accountsClient = createAccountsClient(deps);
    await accountsClient.updateAccounts(accounts);
}

async function updateTransactions() {
    const snapshot = await db.collection('users').doc(uid).get();
    const id = snapshot.get('sbanken_clientid');
    const secret = snapshot.get('sbanken_clientsecret');
    const nationalId = snapshot.get('nationalid');
    const sbankenClient = new SbankenClient(id, secret, nationalId);
    const transactionsClient = createTransactionsClient(deps);

    const accounts = await sbankenClient.getAccounts();
    for (const account of accounts) {
        const transactions = await sbankenClient.getTransactions(account.accountId);
        transactionsClient.updateTransactions(transactions);

    }
}

export const update = functions.https.onRequest(async (request, response) => {
    try {
        await updateAccounts();
        await updateTransactions();
    } catch(e) {
        response.status(500).send({
            message: "Internal server error"
        });
    }
    response.send({
        message: "Successfully updated accounts and transactions"
    });
});