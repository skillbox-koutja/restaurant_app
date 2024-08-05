import 'package:drift/drift.dart';
import 'package:money2/money2.dart';

class MoneyDbConverter extends TypeConverter<Money, String> {
  const MoneyDbConverter();

  @override
  Money fromSql(String fromDb) {
    return Money.parseWithCurrency(fromDb, CommonCurrencies().usd);
  }

  @override
  String toSql(Money value) {
    return value.toString();
  }
}
