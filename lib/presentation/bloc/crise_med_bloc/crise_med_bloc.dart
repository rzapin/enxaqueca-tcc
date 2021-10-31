import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/usecases/crise/get_crises_with_med.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'crise_med_event.dart';

part 'crise_med_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CrisesWithMedBloc extends Bloc<CrisesWithMedEvent, CrisesWithMedState> {
  final GetCrisesWithMed getCrisesWithMed;

  CrisesWithMedBloc({
    @required GetCrisesWithMed crisesWithMed,
  })  : assert(crisesWithMed != null),
        getCrisesWithMed = crisesWithMed;

  @override
  CrisesWithMedState get initialState => CrisesWithMedInitial();

  @override
  Stream<CrisesWithMedState> mapEventToState(
    CrisesWithMedEvent event,
  ) async* {
    if (event is GetCrisesWithMedEvent) {
      yield CrisesWithMedWithMedLoading();

      final failureOrListOfCrisesWithMed = await getCrisesWithMed(
        NoParams(),
      );

      yield failureOrListOfCrisesWithMed.fold(
        (failure) => CrisesWithMedError(message: _mapFailureToMessage(failure)),
        (listOfCrisesWithMed) => CrisesWithMedLoaded(crisesWithMed: listOfCrisesWithMed),
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
