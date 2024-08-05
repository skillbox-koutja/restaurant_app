import 'package:restaurant_app/src/data/db/dao/order_list.dart';
import 'package:restaurant_app/src/domain/entities.dart';
import 'package:restaurant_app/src/domain/values.dart';
import 'package:restaurant_app/src/feature/order_list/repository/models.dart';

class OrderListRepository {
  const OrderListRepository(this._dao);

  final OrderListDao _dao;

  Future<List<Order>> fetchOrders(RestaurantId restaurantId) async {
    final response = await _dao.readAll(restaurantId);

    return response.map((value) => OrderImpl(value: value)).toList();
  }
}
