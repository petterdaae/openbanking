import fetch from 'node-fetch';
import btoa from 'btoa';
import { Account } from '../types';

export default class SbankenClient {
    clientId: string;
    clientSecret: string;
    nationalId: string;

    constructor(clientId: string, clientSecret: string, nationalId: string) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.nationalId = nationalId;
    }

    private async getAccessToken(): Promise<string> {
        const response = await fetch('https://auth.sbanken.no/identityserver/connect/token', {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Authorization': this.buildAuthorizationheader(this.clientId, this.clientSecret),
                'Content-Type': 'application/x-www-form-urlencoded',
                'customId': this.nationalId
            },
            body: 'grant_type=client_credentials'
        });
        const json = await response.json();
        return json.access_token;
    }

    private buildAuthorizationheader(clientId: string, clientSecret: string) {
        return "Basic " + btoa(encodeURIComponent(clientId) + ":" + encodeURIComponent(clientSecret));
    }

    async getAccounts(): Promise<Account[]> {
        const accessToken = await this.getAccessToken();
        const reponse = await fetch('https://api.sbanken.no/exec.bank/api/v1/accounts/', {
            method: 'GET',
            headers: {
                'Authorization': "Bearer " + accessToken,
                'Accept': 'application/json',
                'customerId': this.nationalId
            }
        });

        const json = await reponse.json();

        let accounts: Account[] = [];
        for (const item of json.items) {
            const account: Account = {
                accountId: item.accountId,
                accountNumber: item.accountNumber,
                name: item.name,
                available: item.available,
                balance: item.balance,
                bank: 'sbanken'
            };
            accounts.push(account);
        }

        return accounts;
    }
}
