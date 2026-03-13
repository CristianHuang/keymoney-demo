import 'package:money2/money2.dart';

extension MoneyCompactFormat on Money {
  String compactFormat() {
    // Get the amount in major units as a double
    final double majorUnits = double.parse(amount.toString());

    if (majorUnits >= 1000000) {
      final double millions = majorUnits / 1000000;
      return '${currency.symbol}${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
    } else if (majorUnits >= 10000) {
      final double thousands = majorUnits / 1000;
      return '${currency.symbol}${thousands.toStringAsFixed(thousands.truncateToDouble() == thousands ? 0 : 1)}k';
    } else {
      return toString();
    }
  }
}
