import * as admin from 'firebase-admin';
import Dependencies from './dependencies';
import createUpdateAccountsAndTransactions from './updateAccountsAndTransactions';
import createResetCategories from './resetCategories';
import createResetAccountsAndTransactions from './resetAccountsAndTransactions';

admin.initializeApp();

const deps: Dependencies = {
    firestore: admin.firestore(),
};

export const updateAccountsAndTransactions = createUpdateAccountsAndTransactions(deps);
export const resetCategories = createResetCategories(deps);
export const resetAccountsAndTransactions = createResetAccountsAndTransactions(deps);
