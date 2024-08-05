import 'package:restaurant_app/src/data/db/dao/room_table.dart';
import 'package:restaurant_app/src/domain/entities.dart';
import 'package:restaurant_app/src/domain/values.dart';
import 'package:restaurant_app/src/feature/room_table_service/repository/models.dart';

class RoomTableServiceRepository {
  const RoomTableServiceRepository(this._dao);

  final RoomTableDao _dao;

  Future<List<RoomTable>> fetchRoomTables(RoomId roomId) async {
    final response = await _dao.fetchAll(roomId);

    return response.map((value) => RoomTableImpl(value: value)).toList();
  }
}
