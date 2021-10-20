import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:enxaqueca/domain/usecases/sintoma/delete_sintoma.dart';
import 'package:enxaqueca/domain/usecases/sintoma/get_all_sintomas.dart';
import 'package:enxaqueca/domain/usecases/sintoma/new_sintoma.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sintoma_event.dart';
part 'sintoma_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SintomaBloc extends Bloc<SintomaEvent, SintomaState> {
  final GetAllSintomas getAllSintomas;
  final NewSintoma newSintoma;
  final DeleteSintoma deleteSintoma;

  SintomaBloc({
    @required GetAllSintomas allSintomas,
    @required NewSintoma newSintoma,
    @required DeleteSintoma deleteSintoma,
  })  : assert(allSintomas != null),
        assert(newSintoma != null),
        assert(deleteSintoma != null),
        getAllSintomas = allSintomas,
        newSintoma = newSintoma,
        deleteSintoma = deleteSintoma;

  @override
  SintomaState get initialState => SintomaInitial();

  @override
  Stream<SintomaState> mapEventToState(
    SintomaEvent event,
  ) async* {
    if (event is GetAllSintomasEvent) {
      yield SintomaLoading();

      final failureOrListOfSintomas = await getAllSintomas(
        NoParams(),
      );

      yield failureOrListOfSintomas.fold(
        (failure) => SintomaError(message: _mapFailureToMessage(failure)),
        (listOfSintomas) =>
            SintomaLoaded(sintomas: listOfSintomas),
      );
    } else if (event is NewSintomaEvent) {
      yield SintomaLoading();

      final failureOrUid = await newSintoma(
        NewSintomaParams(sintoma: event.sintoma),
      );

      final failureOrListOfSintomas = await getAllSintomas(
        NoParams(),
      );

      yield failureOrListOfSintomas.fold(
        (failure) => SintomaError(message: _mapFailureToMessage(failure)),
        (listOfSintomas) =>
            SintomaLoaded(sintomas: listOfSintomas),
      );
    } else if (event is DeleteSintomaEvent) {
      yield SintomaLoading();

      final failureOrUid = await deleteSintoma(
        DeleteSintomaParams(uid: event.uid),
      );

      final failureOrListOfSintomas = await getAllSintomas(
        NoParams(),
      );

      yield failureOrListOfSintomas.fold(
        (failure) => SintomaError(message: _mapFailureToMessage(failure)),
        (listOfSintomas) =>
            SintomaLoaded(sintomas: listOfSintomas),
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
