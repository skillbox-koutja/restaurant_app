import 'package:built_collection/src/list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';
import 'package:restaurant_app/src/data/db/dao/table_order.dart';
import 'package:restaurant_app/src/domain/entities.dart';
import 'package:restaurant_app/src/feature/order_list/repository/models.dart';

part 'models.freezed.dart';

@freezed
class TableOrderImpl with _$TableOrderImpl implements TableOrder {
  const TableOrderImpl._();

  const factory TableOrderImpl({
    required DbTableOrder value,
  }) = _TableOrderImpl;

  @override
  Order get order => OrderImpl(value: value.order);

  @override
  BuiltList<OrderProduct> get products => value.products
      .map(
        (v) => OrderProductImpl(value: v),
      )
      .toBuiltList();

  @override
  Money get totalPrice {
    var totalPrice = Money.fromInt(0, isoCode: CommonCurrencies().usd.isoCode);
    for (final product in products) {
      totalPrice += product.totalPrice;
    }

    return totalPrice;
  }
}
