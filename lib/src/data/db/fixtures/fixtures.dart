import 'package:restaurant_app/src/data/db/db.dart';
import 'package:ulid4d/ulid4d.dart';

final _seedTimeStamp = DateTime(2024).millisecondsSinceEpoch;
final _seedId = ULID.nextULID(_prevTimeStamp);
ULID _prevId = _seedId;
int _prevTimeStamp = _seedTimeStamp + 1;

ULID _nextId() {
  final id = ULID.nextMonotonicULID(_prevId, _prevTimeStamp);
  _prevId = id;
  _prevTimeStamp += 1;

  return id;
}

Future<void> loadFixtures(AppDatabase db) async {
  await db.transaction(() async {
    final restaurantId = _nextId();
    await db.into(db.restaurant).insertOnConflictUpdate(
          RestaurantCompanion.insert(
            id: ULID.fromString('01J4F3RQB7H4F2VV36JKHQY2KC'),
            name: 'Restaurant 1',
          ),
        );

    final restaurantRoomId = _nextId();
    await db.into(db.restaurantRoom).insertOnConflictUpdate(
          RestaurantRoomCompanion.insert(
            id: restaurantRoomId,
            name: 'Room 1',
            restaurant: restaurantId.toString(),
          ),
        );

    final roomTableId1 = _nextId();
    await db.into(db.roomTable).insertOnConflictUpdate(
          RoomTableCompanion.insert(
            id: roomTableId1,
            name: 'T 1',
            room: restaurantRoomId.toString(),
          ),
        );

    final roomTableId2 = _nextId();
    await db.into(db.roomTable).insertOnConflictUpdate(
          RoomTableCompanion.insert(
            id: roomTableId2,
            name: 'T 2',
            room: restaurantRoomId.toString(),
          ),
        );
  });
}
