import 'dart:convert';

import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/data/models/gatilho_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GatilhoLocalDataSource {

  Future<GatilhoModel> getLastGatilho();

  Future<void> cacheGatilho(GatilhoModel recordToCache);

  Future<List<GatilhoModel>> getLastListOfGatilhos();

  Future<void> cacheListOfGatilhos(
      List<GatilhoModel> listOfGatilhosToCache);
}

const CACHED_RECORD = 'CACHED_RECORD';

class GatilhoLocalDataSourceImpl implements GatilhoLocalDataSource {
  final SharedPreferences sharedPreferences;

  GatilhoLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<GatilhoModel> getLastGatilho() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(GatilhoModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheGatilho(GatilhoModel recordToCache) {
    return sharedPreferences.setString(
      CACHED_RECORD,
      json.encode(recordToCache.toJson()),
    );
  }

  @override
  Future<List<GatilhoModel>> getLastListOfGatilhos() {
    // TODO: implement getLastListOfGatilhos
    return null;
  }

  @override
  Future<void> cacheListOfGatilhos(
      List<GatilhoModel> listOfGatilhosToCache) {
    // TODO: implement cacheListOfGatilhos
    return null;
  }
}
