import 'package:built_collection/built_collection.dart';
import 'package:money2/money2.dart';

abstract interface class RoomTable {}

abstract interface class Order {}

abstract class OrderProduct {
  int get qty;

  Money get price;

  Money get totalPrice => price * qty;
}

abstract interface class TableOrder {
  Order get order;

  BuiltList<OrderProduct> get products;

  Money get totalPrice;
}
