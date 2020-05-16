import Dependencies from "../dependencies";
import { Transaction } from '../types';
import createAccountsClient, { Accounts } from '../accounts';

class Transactions {
    deps: Dependencies;
    accounts: Accounts;
    uid: string;

    constructor(deps: Dependencies, uid: string) {
        this.deps = deps;
        this.uid = uid;
        this.accounts = createAccountsClient(deps, uid);
    }

    private async equalTransactionsInFirestore(transaction: Transaction): Promise<number> {
        const snapshot = await this.deps.firestore
            .collection('users')
            .doc(this.uid)
            .collection('transactions')
            .where('accountingDate', '==', transaction.accountingDate)
            .where('amount', '==', transaction.amount)
            .where('accountId', '==', transaction.accountId)
            .get();
        return snapshot.size;
    }

    private equalTransactionsInList(transaction: Transaction, transactions: Transaction[]): number {
        const equal = transactions.filter(_transaction =>
            transaction.accountId === _transaction.accountId &&
            transaction.accountingDate === _transaction.accountingDate &&
            transaction.amount === _transaction.amount &&
            transaction.text === _transaction.text
        );
        return equal.length;
    }

    async updateTransactions(transactions: Transaction[]) {
        for (const transaction of transactions) {
            await this.updateTransaction(transaction, transactions);
        }
    }

    private async updateTransaction(transaction: Transaction, transactions: Transaction[]) {
        const equalTransactionsInFirestore = await this.equalTransactionsInFirestore(transaction);
        const equalTransactionsInList = this.equalTransactionsInList(transaction, transactions);
        const difference = equalTransactionsInList - equalTransactionsInFirestore;

        if (difference < 0) {
            throw Error("There should not be more duplicates of a transaction in firestore than retrieved from the api");
        }

        const accountId = await this.accounts.getDocumentIdFromAccountId(transaction.accountIdFromBank);

        for (let i = 0; i < difference; i++) {
            transaction.accountId = accountId;
            await this.deps.firestore
                .collection('users')
                .doc(this.uid)
                .collection('transactions')
                .add(transaction);
        }
    }
}

export default (deps: Dependencies, uid: string) => new Transactions(deps, uid);