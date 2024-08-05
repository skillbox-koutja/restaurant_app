import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:money2/money2.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/src/data/db/converter/money.dart';
import 'package:restaurant_app/src/data/db/converter/ulid.dart';
import 'package:restaurant_app/src/data/db/dao/order_list.dart';
import 'package:restaurant_app/src/data/db/dao/room_table.dart';
import 'package:restaurant_app/src/data/db/dao/table_order.dart';
import 'package:restaurant_app/src/domain/order_status.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:ulid4d/ulid4d.dart';

part 'db.g.dart';
part 'tables.dart';

@DriftDatabase(
  tables: [
    Restaurant,
    RestaurantRoom,
    RoomTable,
    User,
    RestaurantStaff,
    ProductCategory,
    Product,
    RestaurantProduct,
    Order,
    OrderProduct,
  ],
  daos: [
    OrderListDao,
    RoomTableDao,
    TableOrderDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final tempDirectory = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = tempDirectory;

    return NativeDatabase.createInBackground(file);
  });
}
