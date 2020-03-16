export interface Account {
    accountId: string;
    accountNumber: string;
    name: string;
    available: number;
    balance: number;
    bank: string;
}

export interface Transaction {
    accountingDate: Date;
    interestDate: Date;
    amount: number;
    text: string;
    accountId: string;
    accountIdFromBank: string;
}