import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:enxaqueca/data/repositories/crise_repository.dart';
import 'package:enxaqueca/data/repositories/gatilho_repository_impl.dart';
import 'package:enxaqueca/domain/repositories/crise_repository.dart';
import 'package:enxaqueca/domain/repositories/gatilho_repository.dart';
import 'package:enxaqueca/domain/usecases/crise/delete_crise.dart';
import 'package:enxaqueca/domain/usecases/crise/new_crise.dart';
import 'package:enxaqueca/domain/usecases/gatilho/delete_gatilho.dart';
import 'package:enxaqueca/domain/usecases/gatilho/new_gatilho.dart';
import 'package:enxaqueca/domain/usecases/intensidade/update_intensidade.dart';
import 'package:enxaqueca/domain/usecases/sintoma/get_all_sintomas.dart';
import 'package:enxaqueca/domain/usecases/sintoma/new_sintoma.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/crise_med/crise_med_bloc.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/bloc/intensidade/intensidade_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'data/datasources/crise_local_data_source.dart';
import 'data/datasources/crise_remote_data_source.dart';
import 'data/datasources/gatilho_local_data_source.dart';
import 'data/datasources/gatilho_remote_data_source.dart';
import 'data/datasources/intensidade_local_data_source.dart';
import 'data/datasources/intensidade_remote_data_sourde.dart';
import 'data/datasources/medicamento_local_data_source.dart';
import 'data/datasources/medicamento_remote_data_source.dart';
import 'data/datasources/sintoma_local_data_source.dart';
import 'data/datasources/sintoma_remote_data_source.dart';
import 'data/repositories/intensidade_repository_impl.dart';
import 'data/repositories/medicamento_repository_impl.dart';
import 'data/repositories/sintoma_repository_impl.dart';
import 'domain/repositories/intensidade_repository.dart';
import 'domain/repositories/medicamento_repository.dart';
import 'domain/repositories/sintoma_repository.dart';
import 'domain/usecases/crise/get_all_crises.dart';
import 'domain/usecases/crise/get_crises_with_med.dart';
import 'domain/usecases/crise/update_crise.dart';
import 'domain/usecases/gatilho/get_all_gatilhos.dart';
import 'domain/usecases/intensidade/get_all_intensidades.dart';
import 'domain/usecases/medicamento/delete_medicamento.dart';
import 'domain/usecases/medicamento/get_all_medicamentos.dart';
import 'domain/usecases/medicamento/new_medicamento.dart';
import 'domain/usecases/sintoma/delete_sintoma.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp();

  //Crise
  sl.registerFactory(
    () => CriseBloc(
      allCrises: sl(),
      newCrise: sl(),
      deleteCrise: sl(),
      updateCrise: sl(),
    ),
  );
  //Crises apenas com medicamentos
  sl.registerFactory(
        () => CrisesWithMedBloc(
      crisesWithMed: sl(),
    ),
  );
  //Medicamento
  sl.registerFactory(
    () => MedicamentoBloc(
      allMedicamentos: sl(),
      newMedicamento: sl(),
      deleteMedicamento: sl(),
    ),
  );
  //Gatilho
  sl.registerFactory(
    () => GatilhoBloc(
      allGatilhos: sl(),
      newGatilho: sl(),
      deleteGatilho: sl(),
    ),
  );
  //Sintoma
  sl.registerFactory(
    () => SintomaBloc(
      allSintomas: sl(),
      newSintoma: sl(),
      deleteSintoma: sl(),
    ),
  );
  //Intensidade
  sl.registerFactory(
        () => IntensidadeBloc(
      allIntensidades: sl(),
     updateIntensidade: sl(),
    ),
  );

  // CASOS DE USO
  //Crise
  sl.registerLazySingleton(() => GetAllCrises(sl()));
  sl.registerLazySingleton(() => NewCrise(sl()));
  sl.registerLazySingleton(() => DeleteCrise(sl()));
  sl.registerLazySingleton(() => UpdateCrise(sl()));
  //Crise com medicamento cadastrado
  sl.registerLazySingleton(() => GetCrisesWithMed(sl()));
  //Medicamento
  sl.registerLazySingleton(() => GetAllMedicamentos(sl()));
  sl.registerLazySingleton(() => NewMedicamento(sl()));
  sl.registerLazySingleton(() => DeleteMedicamento(sl()));
  //Gatilho
  sl.registerLazySingleton(() => GetAllGatilhos(sl()));
  sl.registerLazySingleton(() => NewGatilho(sl()));
  sl.registerLazySingleton(() => DeleteGatilho(sl()));
  //Sintoma
  sl.registerLazySingleton(() => GetAllSintomas(sl()));
  sl.registerLazySingleton(() => NewSintoma(sl()));
  sl.registerLazySingleton(() => DeleteSintoma(sl()));
  //Intensidade
  sl.registerLazySingleton(() => GetAllIntensidades(sl()));
  sl.registerLazySingleton(() => UpdateIntensidade(sl()));

  // RESPOSITORY
  //Crise
  sl.registerLazySingleton<CriseRepository>(
    () => CriseRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //Medicamento
  sl.registerLazySingleton<MedicamentoRepository>(
    () => MedicamentoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //Gatilho
  sl.registerLazySingleton<GatilhoRepository>(
    () => GatilhoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //Sintoma
  sl.registerLazySingleton<SintomaRepository>(
        () => SintomaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //Sintoma
  sl.registerLazySingleton<IntensidadeRepository>(
        () => IntensidadeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // DATA SOURCES
  //Crise
  sl.registerLazySingleton<CriseRemoteDataSource>(
        () => CriseRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<CriseLocalDataSource>(
        () => CriseLocalDataSourceImpl(sharedPreferences: sl()),
  );
  //Medicamento
  sl.registerLazySingleton<MedicamentoRemoteDataSource>(
    () => MedicamentoRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<MedicamentoLocalDataSource>(
        () => MedicamentoLocalDataSourceImpl(sharedPreferences: sl()),
  );
  //Gatilho
  sl.registerLazySingleton<GatilhoLocalDataSource>(
    () => GatilhoLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<GatilhoRemoteDataSource>(
        () => GatilhoRemoteDataSourceImpl(firestore: sl()),
  );
  //Sintoma
  sl.registerLazySingleton<SintomaLocalDataSource>(
        () => SintomaLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<SintomaRemoteDataSource>(
        () => SintomaRemoteDataSourceImpl(firestore: sl()),
  );
  //Intensidade
  sl.registerLazySingleton<IntensidadeLocalDataSource>(
        () => IntensidadeLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<IntensidadeRemoteDataSource>(
        () => IntensidadeRemoteDataSourceImpl(firestore: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
