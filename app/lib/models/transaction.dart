import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  const Transaction({
    this.accountDocumentId,
    this.accountIdFromBank,
    this.accountingDate,
    this.interestDate,
    this.amount,
    this.text,
  });

  final String accountDocumentId;
  final String accountIdFromBank;
  final DateTime accountingDate;
  final DateTime interestDate;
  final double amount;
  final String text;

  static Transaction parse(DocumentSnapshot snapshot) => Transaction(
        accountDocumentId: snapshot['accountId'],
        accountIdFromBank: snapshot['accountIdFromBank'],
        accountingDate: DateTime.parse(snapshot['accountingDate']),
        amount: double.parse(snapshot['amount'].toString()),
        interestDate: DateTime.parse(snapshot['interestDate']),
        text: snapshot['text'],
      );
}
