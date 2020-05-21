import 'package:app/components/transaction_list_item.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart';
import 'package:app/views/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

class TransactionListComponent extends StatelessWidget {
  TransactionListComponent({
    @required transactions,
    @required categories,
    @required this.hideHiddenTransactions,
    this.scrollController,
  }) {
    var filtered = filter(transactions, categories, hideHiddenTransactions);
    this.transactions = filtered.item1;
    this.categories = filtered.item2;
  }

  List<Transaction> transactions;
  List<Category> categories;
  final ScrollController scrollController;
  final bool hideHiddenTransactions;

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
        child: transactionListItem(index),
      ),
    );
  }

  static Tuple2<List<Transaction>, List<Category>> filter(
    List<Transaction> transactions,
    List<Category> categories,
    bool hideHiddenTransactions,
  ) {
    List<Transaction> filteredTransactions = List();
    List<Category> filteredCategories = List();

    for (int i = 0; i < transactions.length; i++) {
      Transaction transaction = transactions[i];
      Category category = getCategory(transaction, categories);

      if (hideHiddenTransactions && category.hidden) {
        continue;
      }

      filteredTransactions.add(transaction);
      filteredCategories.add(category);
    }

    return Tuple2(filteredTransactions, filteredCategories);
  }

  static Category getCategory(
    Transaction transaction,
    List<Category> categories,
  ) {
    for (Category category in categories) {
      if (transaction.categoryId == category.id) {
        return category;
      }
    }
    return null;
  }

  Widget transactionListItem(int index) {
    final Transaction transaction = transactions[index];
    final Category category = getCategory(transaction, categories);
    if (hideHiddenTransactions && category.static) return null;
    return TransactionListItemComponent(
      transaction: transaction,
      category: category,
    );
  }
}
