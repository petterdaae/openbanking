import 'dart:convert';

import 'package:app/components/avatar_icon.dart';
import 'package:app/models/category.dart';
import 'package:app/models/transaction.dart';
import 'package:app/providers/dependencies.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionDetailsComponent extends StatelessWidget {
  const TransactionDetailsComponent({
    this.transaction,
    this.category,
    this.children,
  });

  final Transaction transaction;
  final Category category;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var utilities = Provider.of<Dependencies>(context).utilities;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8)),
            AvatarIconComponent(category: category, size: 50),
            Padding(padding: EdgeInsets.all(8)),
            transactionDescription(),
            Divider(color: Colors.grey),
            keyValue(
              CommunityMaterialIcons.text,
              "Description",
              transaction.text,
            ),
            Divider(color: Colors.grey),
            keyValue(
              CommunityMaterialIcons.currency_usd,
              "Amount",
              utilities.formatMoney(transaction.amount),
            ),
            Divider(color: Colors.grey),
            keyValue(
              CommunityMaterialIcons.calendar,
              "Accounting date",
              DateFormat("dd. MMM").format(transaction.accountingDate.toDate()),
            ),
            Divider(color: Colors.grey),
            keyValue(
              CommunityMaterialIcons.calendar,
              "Interest date",
              DateFormat("dd. MMM").format(transaction.interestDate.toDate()),
            ),
            transaction.originalJson != null
                ? Divider(color: Colors.grey)
                : Container(),
            transaction.originalJson != null
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: JsonViewerWidget(
                          jsonDecode(transaction.originalJson)),
                    ),
                  )
                : Container(),
            Divider(color: Colors.grey),
            Padding(padding: EdgeInsets.all(8)),
          ]..addAll(children == null ? List() : children),
        ),
      ),
    );
  }

  Widget transactionDescription() {
    return Center(
      child: Text(category == null ? "No category" : category.name),
    );
  }

  Widget keyValue(IconData icon, String key, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Icon(icon)),
          Expanded(flex: 3, child: Text(key)),
          Expanded(flex: 4, child: Text(value)),
        ],
      ),
    );
  }
}
