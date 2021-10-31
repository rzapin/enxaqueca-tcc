import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/domain/usecases/intensidade/get_all_intensidades.dart';
import 'package:enxaqueca/domain/usecases/intensidade/update_intensidade.dart';
import 'package:enxaqueca/domain/usecases/medicamento/get_all_medicamentos.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'intensidade_event.dart';

part 'intensidade_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class IntensidadeBloc extends Bloc<IntensidadeEvent, IntensidadeState> {
  final GetAllIntensidades getAllIntensidades;
  final UpdateIntensidade updateIntensidade;

  IntensidadeBloc({
    @required GetAllIntensidades allIntensidades,
    @required UpdateIntensidade updateIntensidade,
  })  : assert(allIntensidades != null),
        assert(updateIntensidade != null),
        getAllIntensidades = allIntensidades,
        updateIntensidade = updateIntensidade;

  @override
  IntensidadeState get initialState => IntensidadeInitial();

  @override
  Stream<IntensidadeState> mapEventToState(
      IntensidadeEvent event,
      ) async* {
    if (event is GetAllIntensidadesEvent) {
      yield IntensidadeLoading();

      final failureOrListOfIntensidades = await getAllIntensidades(
        NoParams(),
      );

      yield failureOrListOfIntensidades.fold(
            (failure) => IntensidadeError(message: _mapFailureToMessage(failure)),
            (listOfIntensidades) =>
            IntensidadeLoaded(intensidades: listOfIntensidades),
      );
    } else if (event is UpdateIntensidadeEvent) {
      yield IntensidadeLoading();

      final failureOrUid = await updateIntensidade(
        UpdateIntensidadeParams(intensidade: event.intensidade),
      );

      final failureOrListOfIntensidades = await getAllIntensidades(
        NoParams(),
      );

      yield failureOrListOfIntensidades.fold(
            (failure) => IntensidadeError(message: _mapFailureToMessage(failure)),
            (listOfIntensidades) => IntensidadeLoaded(intensidades: listOfIntensidades),
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
