import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:restaurant_app/src/common/widget/not_found_screen.dart';
import 'package:restaurant_app/src/feature/order_list/ui/screen.dart';
import 'package:restaurant_app/src/feature/room_table_service/ui/screen.dart';
import 'package:restaurant_app/src/feature/table_order/ui/screen.dart';

enum Routes with OctopusRoute {
  roomTableService('room-table-service', title: 'Room Table Service'),
  tableOrder('table-order', title: 'Table Order'),
  orderList('order-list', title: 'Order List'),
  notFound('not-found', title: 'Not found');

  const Routes(
    this.name, {
    this.title,
  });

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.roomTableService => const RoomTableServiceScreen(),
        Routes.tableOrder => const TableOrderScreen(),
        Routes.orderList => const OrderListScreen(),
        Routes.notFound => const NotFoundScreen(),
      };
}
