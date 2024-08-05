import 'package:restaurant_app/src/data/db/dao/table_order.dart';
import 'package:restaurant_app/src/domain/values.dart';
import 'package:restaurant_app/src/feature/table_order/repository/models.dart';

class TableOrderRepository {
  const TableOrderRepository(this._dao);

  final TableOrderDao _dao;

  Future<TableOrderImpl> fetch(RoomTableId roomTableId) async {
    final response = await _dao.read(roomTableId);

    return response.map((value) => TableOrderImpl(value: value)).toList();
  }
}
