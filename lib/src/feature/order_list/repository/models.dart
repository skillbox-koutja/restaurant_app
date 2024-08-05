import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/src/money.dart';
import 'package:restaurant_app/src/data/db/db.dart' hide Order, OrderProduct;
import 'package:restaurant_app/src/domain/entities.dart';

part 'models.freezed.dart';

@freezed
class OrderImpl with _$OrderImpl implements Order {
  const OrderImpl._();

  const factory OrderImpl({
    required DbOrder value,
  }) = _OrderImpl;
}

@freezed
class OrderProductImpl with _$OrderProductImpl implements OrderProduct {
  const OrderProductImpl._();

  const factory OrderProductImpl({
    required DbOrderProduct value,
  }) = _OrderProductImpl;

  @override
  Money get price => value.pri;

  @override
  // TODO: implement qty
  int get qty => throw UnimplementedError();

  @override
  // TODO: implement totalPrice
  Money get totalPrice => throw UnimplementedError();
}
