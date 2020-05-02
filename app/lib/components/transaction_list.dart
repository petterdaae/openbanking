import 'package:app/components/transaction_list_item.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart';
import 'package:app/views/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionListComponent extends StatelessWidget {
  const TransactionListComponent({
    @required this.transactions,
    @required this.categories,
    this.scrollController,
  });

  final List<Transaction> transactions;
  final List<Category> categories;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(
        color: Colors.grey,
      ),
      itemCount: transactions.length,
      controller: scrollController,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => TransactionDetails(
                transactionId: transactions[index].id,
              ),
            ),
          );
        },
        child: TransactionListItemComponent(
          transaction: transactions[index],
          category: getCategory(transactions[index]),
        ),
      ),
    );
  }

  Category getCategory(Transaction transaction) {
    for (Category category in categories) {
      if (transaction.categoryId == category.id) {
        return category;
      }
    }
    return null;
  }
}
