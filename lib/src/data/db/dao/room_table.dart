import 'package:drift/drift.dart';
import 'package:restaurant_app/src/data/db/db.dart';
import 'package:restaurant_app/src/domain/values.dart';

part 'room_table.g.dart';

@DriftAccessor(
  tables: [
    RoomTable,
  ],
)
class RoomTableDao extends DatabaseAccessor<AppDatabase> with _$RoomTableDaoMixin {
  RoomTableDao(AppDatabase db) : super(db);

  Future<List<DbRoomTable>> fetchAll(RoomId roomId) async {
    final inRoomTables = alias(roomTable, 'inRoomTables');

    final query = select(inRoomTables).join([
      leftOuterJoin(restaurantRoom, inRoomTables.room.equalsExp(restaurantRoom.id)),
    ])
      ..where(restaurantRoom.id.equalsValue(roomId.value));

    final response = await query.map((row) => row.readTable(inRoomTables)).get();

    return response;
  }
}
