import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_app/src/domain/entities.dart';
import 'package:restaurant_app/src/domain/values.dart';
import 'package:restaurant_app/src/feature/room_table_service/repository/repository.dart';

part 'bloc.freezed.dart';

@Freezed(copyWith: false)
sealed class RoomTableServiceEvent with _$RoomTableServiceEvent {
  const RoomTableServiceEvent._();

  const factory RoomTableServiceEvent.fetch(RoomId roomId) = _FetchEvent;
}

@Freezed()
sealed class RoomTableServiceState with _$RoomTableServiceState {
  const RoomTableServiceState._();

  const factory RoomTableServiceState.initial({
    required BuiltList<RoomTable> data,
  }) = _Initial;

  const factory RoomTableServiceState.loading({
    required BuiltList<RoomTable> data,
  }) = _Loading;

  const factory RoomTableServiceState.error({
    required BuiltList<RoomTable> data,
  }) = _Error;

  const factory RoomTableServiceState.done({
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

class RoomTableServiceBloc extends Bloc<RoomTableServiceEvent, RoomTableServiceState> {
  RoomTableServiceBloc(
    this._roomTableServiceRepository,
  ) : super(
          RoomTableServiceState.initial(
            data: BuiltList(),
          ),
        ) {
    on<RoomTableServiceEvent>(
      (event, emit) => switch (event) {
        _FetchEvent() => _onFetch(event, emit),
      },
    );
  }

  final RoomTableServiceRepository _roomTableServiceRepository;

  Future<void> _onFetch(
    _FetchEvent event,
    Emitter<RoomTableServiceState> emit,
  ) async {
    try {
      emit(RoomTableServiceState.loading(data: state.roomTables));
      final response = await _roomTableServiceRepository.fetchRoomTables(event.roomId);
      emit(RoomTableServiceState.ready(data: response.toBuiltList()));
    } catch (e) {
      emit(RoomTableServiceState.error(data: state.roomTables));
      rethrow;
    }
  }
}
