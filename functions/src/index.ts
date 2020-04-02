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
};

// @ts-ignore
async function updateAccounts() {
    const snapshot = await db.collection('users').doc(uid).get();
    const id = snapshot.get('sbanken_clientid');
    const secret = snapshot.get('sbanken_clientsecret');
    const nationalId = snapshot.get('nationalid');

    const sbankenClient = new SbankenClient(id, secret, nationalId);
    const accounts = await sbankenClient.getAccounts();

    const accountsClient = createAccountsClient(deps);
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
        await transactionsClient.updateTransactions(transactions);

    }
}

export const update = functions.https.onRequest(async (request, response) => {
    if (1 === 1) return;
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

export const changeCategory = functions
  .firestore
  .document('users/{uid}/transactions/{tid}')
  .onUpdate(async (change, context) => {
      // tslint:disable-next-line:no-shadowed-variable
      const uid = context.params.uid;
      const categoryIdBefore = change.before.get('categoryId');
      const categoryIdAfter = change.after.get('categoryId');
      const transactionAmount = change.after.get('amount');

      console.log(`User changed category of transaction; 
                   Uid=${uid}; 
                   OldCategory=${categoryIdBefore}; 
                   NewCategory=${categoryIdAfter}; 
                   Transaction=${change.after.id}`);

      // Category did not change
      if (categoryIdAfter === categoryIdBefore) return;

      // Update old category
      if (categoryIdBefore) {
        await db
          .collection('users')
          .doc(uid)
          .collection('categories')
          .doc(categoryIdBefore)
          .update({
          'balance': admin.firestore.FieldValue.increment(-transactionAmount)
        });
      }

      if (categoryIdAfter) {
        await db
          .collection('users')
          .doc(uid)
          .collection('categories')
          .doc(categoryIdAfter)
          .update({
            'balance': admin.firestore.FieldValue.increment(transactionAmount)
          });
      }
  });