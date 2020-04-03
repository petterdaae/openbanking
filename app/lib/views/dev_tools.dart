import 'package:app/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cf = Provider.of<Dependencies>(context).cloudFunctions;
    return Column(
      children: <Widget>[
        Center(
          child: FlatButton(
            onPressed: () async {
              var response = await cf
                  .getHttpsCallable(functionName: 'resetCategories')
                  .call();
              print(response.data);
            },
            child: Text(
              "Reset Categories",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
