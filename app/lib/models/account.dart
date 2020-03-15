import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  const Account({
    this.accountId,
    this.accountNumber,
    this.available,
    this.balance,
    this.bank,
    this.name,
  });

  final String accountId;
  final String accountNumber;
  final double available;
  final double balance;
  final String bank;
  final String name;

  static Account parse(DocumentSnapshot snapshot) => Account(
        accountId: snapshot['accountId'],
        accountNumber: snapshot['accountNumber'],
        available: double.parse(snapshot['available'].toString()),
        balance: double.parse(snapshot['balance'].toString()),
        bank: snapshot['bank'],
        name: snapshot['name'],
      );
}
