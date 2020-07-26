export interface Account {
    accountId: string;
    accountNumber: string;
    name: string;
    available: number;
    balance: number;
    bank: string;
}

export interface Transaction {
    accountingDate: number | null;
    interestDate: number | null;
    amount: number;
    text: string;
    accountId: string;
    accountIdFromBank: string;
    originalJson: string;
}