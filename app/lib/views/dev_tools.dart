import 'package:app/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DevCallFunctionButton(
          "Reset Categories",
          "resetCategories",
        ),
        DevCallFunctionButton(
          "Delete accounts and transactions",
          "resetAccountsAndTransactions",
        ),
        DevCallFunctionButton(
          "Update accounts and transactions",
          "updateAccountsAndTransactions",
        ),
      ],
    );
  }
}

class DevCallFunctionButton extends StatelessWidget {
  const DevCallFunctionButton(this.buttonText, this.functionName);

  final String functionName;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    var cf = Provider.of<Dependencies>(context).cloudFunctions;
    return Center(
      child: FlatButton(
        onPressed: () async {
          var response =
              await cf.getHttpsCallable(functionName: functionName).call();
          print(response.data);
        },
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.red,
      ),
    );
  }
}
