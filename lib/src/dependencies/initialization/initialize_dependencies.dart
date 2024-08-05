import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'package:restaurant_app/src/common/bloc_observer.dart';
import 'package:restaurant_app/src/data/db/db.dart';
import 'package:restaurant_app/src/dependencies/initialization/platform/initialization.dart';
import 'package:restaurant_app/src/dependencies/model/dependencies.dart';
import 'package:restaurant_app/src/feature/order_list/repository/repository.dart';
import 'package:restaurant_app/src/feature/room_table_service/repository/repository.dart';
import 'package:restaurant_app/src/feature/table_order/repository/repository.dart';

/// Initializes the app and returns a [Dependencies] object
Future<Dependencies> $initializeDependencies({
  void Function(int progress, String message)? onProgress,
}) async {
  final dependencies = Dependencies();
  final totalSteps = _initializationSteps.length;
  var currentStep = 0;
  for (final step in _initializationSteps.entries) {
    try {
      currentStep++;
      final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      onProgress?.call(percent, step.key);
      l.v6('Initialization | $currentStep/$totalSteps ($percent%) | "${step.key}"');
      await step.value(dependencies);
    } catch (error, stackTrace) {
      l.e('Initialization failed at step "${step.key}": $error', stackTrace);
      Error.throwWithStackTrace('Initialization failed at step "${step.key}": $error', stackTrace);
    }
  }
  return dependencies;
}

typedef _InitializationStep = FutureOr<void> Function(Dependencies deps);

final Map<String, _InitializationStep> _initializationSteps = {
  'Platform pre-initialization': (_) => $platformInitialization(),
  'Observer state management': (_) {
    Bloc.observer = AppBlocObserver();
  },
  'Prepare Database': (deps) async => deps.db = AppDatabase(),
  'Prepare RoomTableService repository': (deps) => deps.roomTableServiceRepository = RoomTableServiceRepository(
        deps.db.roomTableDao,
      ),
  'Prepare TableOrder repository': (deps) => deps.tableOrderRepository = TableOrderRepository(
        deps.db.tableOrderDao,
      ),
  'Prepare OrderList repository': (deps) => deps.orderListRepository = OrderListRepository(
        deps.db.orderListDao,
      ),
  'Log app initialized': (_) {},
};
