import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/domain/usecases/gatilho/delete_gatilho.dart';
import 'package:enxaqueca/domain/usecases/gatilho/get_all_gatilhos.dart';
import 'package:enxaqueca/domain/usecases/gatilho/new_gatilho.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'gatilho_event.dart';
part 'gatilho_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class GatilhoBloc extends Bloc<GatilhoEvent, GatilhoState> {
  final GetAllGatilhos getAllGatilhos;
  final NewGatilho newGatilho;
  final DeleteGatilho deleteGatilho;

  GatilhoBloc({
    @required GetAllGatilhos allGatilhos,
    @required NewGatilho newGatilho,
    @required DeleteGatilho deleteGatilho,
  })  : assert(allGatilhos != null),
        assert(newGatilho != null),
        assert(deleteGatilho != null),
        getAllGatilhos = allGatilhos,
        newGatilho = newGatilho,
        deleteGatilho = deleteGatilho;

  @override
  GatilhoState get initialState => GatilhoInitial();

  @override
  Stream<GatilhoState> mapEventToState(
    GatilhoEvent event,
  ) async* {
    if (event is GetAllGatilhosEvent) {
      yield GatilhoLoading();

      final failureOrListOfGatilhos = await getAllGatilhos(
        NoParams(),
      );

      yield failureOrListOfGatilhos.fold(
        (failure) => GatilhoError(message: _mapFailureToMessage(failure)),
        (listOfGatilhos) =>
            GatilhoLoaded(gatilhos: listOfGatilhos),
      );
    } else if (event is NewGatilhoEvent) {
      yield GatilhoLoading();

      final failureOrUid = await newGatilho(
        NewGatilhoParams(gatilho: event.gatilho),
      );

      final failureOrListOfGatilhos = await getAllGatilhos(
        NoParams(),
      );

      yield failureOrListOfGatilhos.fold(
        (failure) => GatilhoError(message: _mapFailureToMessage(failure)),
        (listOfGatilhos) =>
            GatilhoLoaded(gatilhos: listOfGatilhos),
      );
    } else if (event is DeleteGatilhoEvent) {
      yield GatilhoLoading();

      final failureOrUid = await deleteGatilho(
        DeleteGatilhoParams(uid: event.uid),
      );

      final failureOrListOfGatilhos = await getAllGatilhos(
        NoParams(),
      );

      yield failureOrListOfGatilhos.fold(
        (failure) => GatilhoError(message: _mapFailureToMessage(failure)),
        (listOfGatilhos) =>
            GatilhoLoaded(gatilhos: listOfGatilhos),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
