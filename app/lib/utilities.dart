import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Utilities {
  String formatMoney(double amount) {
    final MoneyMaskedTextController formatter = MoneyMaskedTextController(
      initialValue: amount,
      decimalSeparator: ".",
      thousandSeparator: " ",
      rightSymbol: " kr",
    );
    return formatter.text;
  }
}

class StreamBuilder2<S1 extends Stream<S1>, S2 extends Stream<S2>>
    extends StatelessWidget {
  const StreamBuilder2({
    @required this.stream1,
    @required this.stream2,
    @required this.builder,
  });

  final S1 stream1;
  final S2 stream2;
  final Widget Function(BuildContext, AsyncSnapshot<S1>, AsyncSnapshot<S2>)
      builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S1>(
      stream: stream1,
      builder: (
        BuildContext context1,
        AsyncSnapshot<S1> snapshot1,
      ) {
        return StreamBuilder(
          stream: stream2,
          builder: (
            BuildContext context2,
            AsyncSnapshot<S2> snapshot2,
          ) {
            return builder(context2, snapshot1, snapshot2);
          },
        );
      },
    );
  }
}
