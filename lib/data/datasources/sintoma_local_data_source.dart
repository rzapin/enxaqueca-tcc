import 'dart:convert';

import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/data/models/sintoma_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SintomaLocalDataSource {

  Future<SintomaModel> getLastSintoma();

  Future<void> cacheSintoma(SintomaModel recordToCache);

  Future<List<SintomaModel>> getLastListOfSintomas();

  Future<void> cacheListOfSintomas(
      List<SintomaModel> listOfSintomasToCache);
}

const CACHED_RECORD = 'CACHED_RECORD';

class SintomaLocalDataSourceImpl implements SintomaLocalDataSource {
  final SharedPreferences sharedPreferences;

  SintomaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<SintomaModel> getLastSintoma() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(SintomaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSintoma(SintomaModel recordToCache) {
    return sharedPreferences.setString(
      CACHED_RECORD,
      json.encode(recordToCache.toJson()),
    );
  }

  @override
  Future<List<SintomaModel>> getLastListOfSintomas() {
    // TODO: implement getLastListOfSintomas
    return null;
  }

  @override
  Future<void> cacheListOfSintomas(
      List<SintomaModel> listOfSintomasToCache) {
    // TODO: implement cacheListOfSintomas
    return null;
  }
}
