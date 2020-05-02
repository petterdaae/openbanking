import admin from "firebase-admin";

export interface Account {
    accountId: string;
    accountNumber: string;
    name: string;
    available: number;
    balance: number;
    bank: string;
}

export interface Transaction {
    accountingDate: admin.firestore.Timestamp | null;
    interestDate: admin.firestore.Timestamp | null;
    amount: number;
    text: string;
    accountId: string;
    accountIdFromBank: string;
}