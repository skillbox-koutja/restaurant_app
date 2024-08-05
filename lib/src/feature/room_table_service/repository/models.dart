import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_app/src/data/db/db.dart' hide RoomTable;
import 'package:restaurant_app/src/domain/entities.dart';

part 'models.freezed.dart';

@freezed
class RoomTableImpl with _$RoomTableImpl implements RoomTable {
  const RoomTableImpl._();

  const factory RoomTableImpl({
    required DbRoomTable value,
  }) = _RoomTableImpl;
}
