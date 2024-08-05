import 'package:drift/drift.dart';
import 'package:restaurant_app/src/data/db/db.dart';
import 'package:restaurant_app/src/domain/values.dart';

part 'order_list.g.dart';

typedef DbOrderWithProducts = ({
  DbOrder order,
  DbOrderProduct orderProduct,
  DbRestaurantProduct restaurantProduct,
  DbProduct product,
});

@DriftAccessor(
  tables: [
    Order,
    OrderProduct,
  ],
)
class OrderListDao extends DatabaseAccessor<AppDatabase> with _$OrderListDaoMixin {
  OrderListDao(AppDatabase db) : super(db);

  Future<List<DbOrderWithProducts>> readAllByWaiter({
    required RestaurantId restaurantId,
    required WaiterId waiterId,
  }) async {
    final query = select(order).join([
      innerJoin(
        restaurantRoom,
        order.roomTable.equalsExp(restaurantRoom.id),
      ),
      innerJoin(
        restaurant,
        restaurantRoom.restaurant.equalsExp(restaurant.id),
      ),
      leftOuterJoin(
        orderProduct,
        orderProduct.order.equalsExp(order.id),
      ),
      leftOuterJoin(
        restaurantProduct,
        restaurantProduct.id.equalsExp(orderProduct.product) & restaurantProduct.restaurant.equalsExp(restaurant.id),
      ),
      leftOuterJoin(
        product,
        product.id.equalsExp(restaurantProduct.product),
      )
    ])
      ..where(
        restaurant.id.equals(restaurantId.value.toString()) & order.waiter.equals(waiterId.value.toString()),
      );

    final response = await query
        .map(
          (row) => (
            order: row.readTable(order),
            orderProduct: row.readTable(orderProduct),
            restaurantProduct: row.readTable(restaurantProduct),
            product: row.readTable(product),
          ),
        )
        .get();

    return response;
  }
}
