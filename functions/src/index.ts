import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import SbankenClient from './sbanken';
import Dependencies from './dependencies';
import createAccountsClient from './accounts';

admin.initializeApp();
const db = admin.firestore();
const uid = 'EKDRNcDbDgUYbdGyFFUevSLBrW33';

const deps: Dependencies = {
    firestore: db,
    uid: uid
}

export const updateAccounts = functions.https.onRequest(async (request, response) => {
    try {
        const snapshot = await db.collection('users').doc(uid).get();
        const id = snapshot.get('sbanken_clientid');
        const secret = snapshot.get('sbanken_clientsecret');
        const nationalId = snapshot.get('nationalid');

        let sbankenClient = new SbankenClient(id, secret, nationalId);
        let accounts = await sbankenClient.getAccounts();

        let accountsClient = createAccountsClient(deps);
        await accountsClient.updateAccounts(accounts);

        response.send({
            message: "Successfully updated accounts"
        });
    } catch (_) {
        response.status(500).send({
            message: "Failed to update accounts"
        });
    }
});
