import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/usecases/crise/delete_crise.dart';
import 'package:enxaqueca/domain/usecases/crise/get_all_crises.dart';
import 'package:enxaqueca/domain/usecases/crise/new_crise.dart';
import 'package:enxaqueca/domain/usecases/crise/update_crise.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'crise_event.dart';
part 'crise_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CriseBloc extends Bloc<CriseEvent, CriseState> {
  final GetAllCrises getAllCrises;
  final NewCrise newCrise;
  final DeleteCrise deleteCrise;
  final UpdateCrise updateCrise;

  CriseBloc({
    @required GetAllCrises allCrises,
    @required NewCrise newCrise,
    @required DeleteCrise deleteCrise,
    @required UpdateCrise updateCrise,
  })  : assert(allCrises != null),
        assert(newCrise != null),
        assert(deleteCrise != null),
        assert(updateCrise != null),
        getAllCrises = allCrises,
        newCrise = newCrise,
        deleteCrise = deleteCrise,
        updateCrise = updateCrise;

  @override
  CriseState get initialState => CriseInitial();

  @override
  Stream<CriseState> mapEventToState(
    CriseEvent event,
  ) async* {
    if (event is GetAllCrisesEvent) {
      yield CriseLoading();

      final failureOrListOfCrises = await getAllCrises(
        NoParams(),
      );

      yield failureOrListOfCrises.fold(
        (failure) => CriseError(message: _mapFailureToMessage(failure)),
        (listOfCrises) =>
            CriseLoaded(crises: listOfCrises),
      );
    } else if (event is NewCriseEvent) {
      yield CriseLoading();

      final failureOrUid = await newCrise(
        NewCriseParams(crise: event.crise),
      );

      final failureOrListOfCrises = await getAllCrises(
        NoParams(),
      );

      yield failureOrListOfCrises.fold(
        (failure) => CriseError(message: _mapFailureToMessage(failure)),
        (listOfCrises) =>
            CriseLoaded(crises: listOfCrises),
      );
    } else if (event is DeleteCriseEvent) {
      yield CriseLoading();

      final failureOrUid = await deleteCrise(
        DeleteCriseParams(uid: event.uid),
      );

      final failureOrListOfCrises = await getAllCrises(
        NoParams(),
      );

      yield failureOrListOfCrises.fold(
        (failure) => CriseError(message: _mapFailureToMessage(failure)),
        (listOfCrises) =>
            CriseLoaded(crises: listOfCrises),
      );
    } else if (event is UpdateCriseEvent) {
      yield CriseLoading();

      final failureOrUid = await updateCrise(
        UpdateCriseParams(crise: event.crise),
      );

      final failureOrListOfCrises = await getAllCrises(
        NoParams(),
      );

      yield failureOrListOfCrises.fold(
            (failure) => CriseError(message: _mapFailureToMessage(failure)),
            (listOfCrises) =>
            CriseLoaded(crises: listOfCrises),
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
