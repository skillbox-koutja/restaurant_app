import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_app/src/domain/entities.dart';
import 'package:restaurant_app/src/domain/values.dart';
import 'package:restaurant_app/src/feature/room_table_service/repository/repository.dart';

part 'bloc.freezed.dart';

@Freezed(copyWith: false)
sealed class TableOrderServiceEvent with _$TableOrderServiceEvent {
  const TableOrderServiceEvent._();

  const factory TableOrderServiceEvent.fetch(RoomId roomId) = _FetchEvent;
}

@Freezed()
sealed class TableOrderServiceState with _$TableOrderServiceState {
  const TableOrderServiceState._();

  const factory TableOrderServiceState.initial({
    required BuiltList<RoomTable> data,
  }) = _Initial;

  const factory TableOrderServiceState.loading({
    required BuiltList<RoomTable> data,
  }) = _Loading;

  const factory TableOrderServiceState.error({
    required BuiltList<RoomTable> data,
  }) = _Error;

  const factory TableOrderServiceState.done({
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

class TableOrderServiceBloc extends Bloc<TableOrderServiceEvent, TableOrderServiceState> {
  TableOrderServiceBloc(
    this._TableOrderServiceRepository,
  ) : super(
          TableOrderServiceState.initial(
            data: BuiltList(),
          ),
        ) {
    on<TableOrderServiceEvent>(
      (event, emit) => switch (event) {
        _FetchEvent() => _onFetch(event, emit),
      },
    );
  }

  final TableOrderServiceRepository _TableOrderServiceRepository;

  Future<void> _onFetch(
    _FetchEvent event,
    Emitter<TableOrderServiceState> emit,
  ) async {
    try {
      emit(TableOrderServiceState.loading(data: state.roomTables));
      final response = await _TableOrderServiceRepository.fetchRoomTables(event.roomId);
      emit(TableOrderServiceState.ready(data: response.toBuiltList()));
    } catch (e) {
      emit(TableOrderServiceState.error(data: state.roomTables));
      rethrow;
    }
  }
}
