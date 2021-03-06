import admin from "firebase-admin";
import Dependencies from "./dependencies";
import { Account } from './types';

type Firestore = admin.firestore.Firestore;

export class Accounts {
    firestore: Firestore;
    userId: string;

    constructor(firestore: Firestore, userId: string) {
        this.firestore = firestore;
        this.userId = userId;
    }

    async accountExists(account: Account): Promise<boolean> {
        const snapshot = await this.firestore
            .collection('users')
            .doc(this.userId)
            .collection('accounts')
            .where('accountId', '==', account.accountId)
            .where('accountNumber', '==', account.accountNumber)
            .where('bank', '==', account.bank)
            .get();
        return !snapshot.empty;
    }

    async getAccount(account: Account) {
        const snapshot = await this.firestore
            .collection('users')
            .doc(this.userId)
            .collection('accounts')
            .where('accountId', '==', account.accountId)
            .where('accountNumber', '==', account.accountNumber)
            .where('bank', '==', account.bank)
            .get();
        return !snapshot.empty;
    }

    async getDocumentIdFromAccountId(idFromBank: string) {
        const snapshot = await this.firestore
            .collection('users')
            .doc(this.userId)
            .collection('accounts')
            .where('accountId', '==', idFromBank)
            .get();
        const doc = snapshot.docs[0];
        return doc.id;
    }

    async updateAccount(account: Account): Promise<void> {
        const exists = await this.accountExists(account);
        if (!exists) {
            await this.firestore
                .collection('users')
                .doc(this.userId)
                .collection('accounts')
                .add(account);
        } else {
            const snapshot = await this.firestore
                .collection('users')
                .doc(this.userId)
                .collection('accounts')
                .where('accountId', '==', account.accountId)
                .where('accountNumber', '==', account.accountNumber)
                .where('bank', '==', account.bank)
                .get();
            const accountRef = snapshot.docs[0];
            await this.firestore
                .collection('users')
                .doc(this.userId)
                .collection('accounts')
                .doc(accountRef.id)
                .update(account);
        }
    }

    async updateAccounts(accounts: Account[]) {
        for (const account of accounts) {
            await this.updateAccount(account);
        }
    }
}

export default (deps: Dependencies, uid: string) => new Accounts(deps.firestore, uid);