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
