import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  const Transaction({
    this.accountDocumentId,
    this.accountIdFromBank,
    this.accountingDate,
    this.interestDate,
    this.amount,
    this.text,
    this.id,
    this.categoryId,
    this.originalJson,
  });

  final String accountDocumentId;
  final String accountIdFromBank;
  final Timestamp accountingDate;
  final Timestamp interestDate;
  final double amount;
  final String text;
  final String id;
  final String categoryId;
  final String originalJson;

  static Transaction parse(DocumentSnapshot snapshot) => Transaction(
        accountDocumentId: snapshot['accountId'],
        accountIdFromBank: snapshot['accountIdFromBank'],
        accountingDate:
            Timestamp.fromMillisecondsSinceEpoch(snapshot['accountingDate']),
        amount: double.parse(snapshot['amount'].toString()),
        interestDate:
            Timestamp.fromMillisecondsSinceEpoch(snapshot['interestDate']),
        text: snapshot['text'],
        id: snapshot.documentID,
        categoryId: snapshot['categoryId'],
        originalJson: snapshot["originalJson"],
      );
}
