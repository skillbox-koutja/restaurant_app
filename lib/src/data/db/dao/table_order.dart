import 'package:drift/drift.dart';
import 'package:restaurant_app/src/data/db/db.dart';
import 'package:restaurant_app/src/domain/values.dart';

part 'table_order.g.dart';

typedef DbTableOrder = ({
  DbOrder order,
  List<DbOrderProduct> products,
});

@DriftAccessor(
  tables: [
    Order,
    OrderProduct,
  ],
)
class TableOrderDao extends DatabaseAccessor<AppDatabase> with _$TableOrderDaoMixin {
  TableOrderDao(AppDatabase db) : super(db);

  Future<DbTableOrder> read(RoomTableId roomTableId) async {
    final order = await _readOrder(roomTableId);
    final products = await _readProducts(order);

    return (
      order: order,
      products: products,
    );
  }

  Future<DbOrder> _readOrder(RoomTableId roomTableId) async {
    final query = select(order)
      ..where(
        (t) => t.roomTable.equals(roomTableId.value.toString()),
      );
    final response = await query.getSingle();

    return response;
  }

  Future<List<DbOrderProduct>> _readProducts(DbOrder order) async {
    final query = select(orderProduct)
      ..where(
        (t) => t.order.equals(order.id.toString()),
      );

    final response = await query.get();

    return response;
  }
}
