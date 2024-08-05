import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_app/src/domain/entities.dart';
import 'package:restaurant_app/src/domain/values.dart';
import 'package:restaurant_app/src/feature/order_list/repository/repository.dart';

part 'bloc.freezed.dart';

@Freezed(copyWith: false)
sealed class OrderListEvent with _$OrderListEvent {
  const OrderListEvent._();

  const factory OrderListEvent.fetch(RoomId roomId) = _FetchEvent;
}

@Freezed()
sealed class OrderListState with _$OrderListState {
  const OrderListState._();

  const factory OrderListState.initial({
    required BuiltList<RoomTable> data,
  }) = _Initial;

  const factory OrderListState.loading({
    required BuiltList<RoomTable> data,
  }) = _Loading;

  const factory OrderListState.error({
    required BuiltList<RoomTable> data,
  }) = _Error;

  const factory OrderListState.done({
    required BuiltList<RoomTable> data,
  }) = _Done;

  bool get isLoading => switch (this) {
        _Loading() => true,
        _ => false,
      };

  BuiltList<RoomTable> get roomTables => switch (this) {
        _Initial(data: final data) => data,
        _Loading(data: final data) => data,
        _Error(data: final data) => data,
        _Done(data: final data) => data,
      };
}

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc(
    this._orderListRepository,
  ) : super(
          OrderListState.initial(
            data: BuiltList(),
          ),
        ) {
    on<OrderListEvent>(
      (event, emit) => switch (event) {
        _FetchEvent() => _onFetch(event, emit),
      },
    );
  }

  final OrderListRepository _orderListRepository;

  Future<void> _onFetch(
    _FetchEvent event,
    Emitter<OrderListState> emit,
  ) async {
    try {
      emit(OrderListState.loading(data: state.roomTables));
      final response = await _orderListRepository.fetchRoomTables(event.roomId);
      emit(OrderListState.ready(data: response.toBuiltList()));
    } catch (e) {
      emit(OrderListState.error(data: state.roomTables));
      rethrow;
    }
  }
}
