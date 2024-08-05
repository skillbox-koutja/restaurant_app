import 'package:equatable/equatable.dart';
import 'package:ulid4d/ulid4d.dart';

class RestaurantId extends _IdEntity<ULID> {
  const RestaurantId(super.value);
}

class WaiterId extends _IdEntity<ULID> {
  const WaiterId(super.value);
}

class RoomId extends _IdEntity<ULID> {
  const RoomId(super.value);
}

class RoomTableId extends _IdEntity<ULID> {
  const RoomTableId(super.value);
}

class OrderId extends _IdEntity<ULID> {
  const OrderId(super.value);
}

class _IdEntity<T extends Object> extends Equatable {
  const _IdEntity(this.value);

  final T value;

  @override
  List<Object> get props => [value];
}
