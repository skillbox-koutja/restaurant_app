import 'package:flutter/widgets.dart';
import 'package:restaurant_app/src/data/db/db.dart';
import 'package:restaurant_app/src/dependencies/widget/dependencies_scope.dart';
import 'package:restaurant_app/src/feature/order_list/repository/repository.dart';
import 'package:restaurant_app/src/feature/room_table_service/repository/repository.dart';
import 'package:restaurant_app/src/feature/table_order/repository/repository.dart';

/// Dependencies
class Dependencies {
  Dependencies();

  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) => DependenciesScope.of(context);

  late final AppDatabase db;

  late final RoomTableServiceRepository roomTableServiceRepository;
  late final TableOrderRepository tableOrderRepository;
  late final OrderListRepository orderListRepository;
}
