import 'package:app/providers/dependencies.dart';
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
          true,
        ),
        DevCallFunctionButton(
          "Delete accounts and transactions",
          "resetAccountsAndTransactions",
          true,
        ),
        DevCallFunctionButton(
          "Update accounts and transactions",
          "updateAccountsAndTransactions",
          false,
        ),
      ],
    );
  }
}

class DevCallFunctionButton extends StatelessWidget {
  const DevCallFunctionButton(
    this.buttonText,
    this.functionName,
    this.disabled,
  );

  final String functionName;
  final String buttonText;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    var cf = Provider.of<Dependencies>(context).cloudFunctions;
    return Center(
      child: FlatButton(
        onPressed: disabled
            ? () {}
            : () async {
                var response = await cf
                    .getHttpsCallable(functionName: functionName)
                    .call();
                print(response.data);
              },
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
        color: disabled ? Colors.black : Colors.red,
      ),
    );
  }
}
