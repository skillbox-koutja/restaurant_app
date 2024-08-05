import 'package:drift/drift.dart';
import 'package:ulid4d/ulid4d.dart';

class UlidDbConverter extends TypeConverter<ULID, String> {
  const UlidDbConverter();

  @override
  ULID fromSql(String fromDb) {
    return ULID.fromString(fromDb);
  }

  @override
  String toSql(ULID value) {
    return value.toString();
  }
}
