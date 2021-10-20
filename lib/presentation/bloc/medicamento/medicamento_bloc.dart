import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/domain/usecases/medicamento/delete_medicamento.dart';
import 'package:enxaqueca/domain/usecases/medicamento/get_all_medicamentos.dart';
import 'package:enxaqueca/domain/usecases/medicamento/get_medicamento.dart';
import 'package:enxaqueca/domain/usecases/medicamento/get_nome_medicamentos.dart';
import 'package:enxaqueca/domain/usecases/medicamento/new_medicamento.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'medicamento_event.dart';
part 'medicamento_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class MedicamentoBloc extends Bloc<MedicamentoEvent, MedicamentoState> {
  final GetAllMedicamentos getAllMedicamentos;
  final GetNomeMedicamentos getNomeMedicamentos;
  final NewMedicamento newMedicamento;
  final DeleteMedicamento deleteMedicamento;
  final GetMedicamento getMedicamento;

  MedicamentoBloc({
    @required GetAllMedicamentos allMedicamentos,
    @required GetNomeMedicamentos nomeMedicamentos,
    @required NewMedicamento newMedicamento,
    @required DeleteMedicamento deleteMedicamento,
    @required GetMedicamento getMedicamento,
  })  : assert(allMedicamentos != null),
        assert(newMedicamento != null),
        assert(deleteMedicamento != null),
        //assert(nomeMedicamentos != null),
        //  assert(getMedicamento != null),
        getAllMedicamentos = allMedicamentos,
        getNomeMedicamentos = nomeMedicamentos,
        newMedicamento = newMedicamento,
        deleteMedicamento = deleteMedicamento,
        getMedicamento = getMedicamento;

  @override
  MedicamentoState get initialState => MedicamentoInitial();

  @override
  Stream<MedicamentoState> mapEventToState(
    MedicamentoEvent event,
  ) async* {
    if (event is GetAllMedicamentosEvent) {
      yield MedicamentoLoading();

      final failureOrListOfMedicamentos = await getAllMedicamentos(
        NoParams(),
      );

      yield failureOrListOfMedicamentos.fold(
        (failure) => MedicamentoError(message: _mapFailureToMessage(failure)),
        (listOfMedicamentos) =>
            MedicamentoLoaded(medicamentos: listOfMedicamentos),
      );
    } else if (event is GetNomeMedicamentosEvent) {
      yield MedicamentoLoading();

      final failureOrListOfMedicamentos = await getNomeMedicamentos(
        NoParams(),
      );

      yield failureOrListOfMedicamentos.fold(
        (failure) => MedicamentoError(message: _mapFailureToMessage(failure)),
        (listOfMedicamentos) =>
            MedicamentoLoaded(medicamentos: listOfMedicamentos),
      );
    } else if (event is NewMedicamentoEvent) {
      yield MedicamentoLoading();

      final failureOrUid = await newMedicamento(
        NewMedicamentoParams(medicamento: event.medicamento),
      );

      final failureOrListOfMedicamentos = await getAllMedicamentos(
        NoParams(),
      );

      yield failureOrListOfMedicamentos.fold(
        (failure) => MedicamentoError(message: _mapFailureToMessage(failure)),
        (listOfMedicamentos) =>
            MedicamentoLoaded(medicamentos: listOfMedicamentos),
      );
    } else if (event is GetAllMedicamentosEvent) {
      yield MedicamentoLoading();

      final failureOrListOfMedicamentos = await getAllMedicamentos(
        NoParams(),
      );

      yield failureOrListOfMedicamentos.fold(
        (failure) => MedicamentoError(message: _mapFailureToMessage(failure)),
        (listOfMedicamentos) =>
            MedicamentoLoaded(medicamentos: listOfMedicamentos),
      );
    } else if (event is NewMedicamentoEvent) {
      yield MedicamentoLoading();

      final failureOrUid = await newMedicamento(
        NewMedicamentoParams(medicamento: event.medicamento),
      );

      final failureOrListOfMedicamentos = await getAllMedicamentos(
        NoParams(),
      );

      yield failureOrListOfMedicamentos.fold(
        (failure) => MedicamentoError(message: _mapFailureToMessage(failure)),
        (listOfMedicamentos) =>
            MedicamentoLoaded(medicamentos: listOfMedicamentos),
      );
    } else if (event is DeleteMedicamentoEvent) {
      yield MedicamentoLoading();

      final failureOrUid = await deleteMedicamento(
        DeleteMedicamentoParams(uid: event.uid),
      );

      final failureOrListOfMedicamentos = await getAllMedicamentos(
        NoParams(),
      );

      yield failureOrListOfMedicamentos.fold(
        (failure) => MedicamentoError(message: _mapFailureToMessage(failure)),
        (listOfMedicamentos) =>
            MedicamentoLoaded(medicamentos: listOfMedicamentos),
      );
    } else if (event is GetMedicamentoEvent) {
      //getMedicamento(Params(uid: event.uid));
      yield MedicamentoLoading();

      final failureOrMedicamento = await getMedicamento(
        GetMedicamentoParams(uid: event.uid),
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
