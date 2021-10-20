import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/data/models/gatilho_model.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:meta/meta.dart';

abstract class GatilhoRemoteDataSource {
  Future<List<GatilhoModel>> getAllGatilhos();

  Future<GatilhoModel> getGatilho(String uid);

  Future<String> newGatilho(Gatilho gatilho);

  Future<void> deleteGatilho(String uid);
}

class GatilhoRemoteDataSourceImpl implements GatilhoRemoteDataSource {
  final FirebaseFirestore firestore;

  GatilhoRemoteDataSourceImpl({@required this.firestore});

  @override
  Future<List<GatilhoModel>> getAllGatilhos() async {
    var result = await firestore.collection('gatilhos').get();

    List<GatilhoModel> listGatilhoModel = result.docs
        .map((doc) => GatilhoModel(
              id: doc.id,
              nome: doc.get('nome'),
              diaHora: doc.get('diaHora').toDate(),
              //  userId: doc.get('userId')
            ))
        .toList();

    return listGatilhoModel;
  }

  @override
  Future<GatilhoModel> getGatilho(String uid) async {
    Map<String, dynamic> data =
        (await firestore.collection('gatilhos').doc(uid).get()).data();

    return GatilhoModel.fromJson(data);
  }

  @override
  Future<String> newGatilho(Gatilho gatilho) async {
    final docRef = firestore.collection("gatilhos").add({
      'nome': gatilho.nome,
      'diaHora': gatilho.diaHora,
      //'userId': gatilho.userId
    });
    return docRef.toString();
  }

  @override
  Future<void> deleteGatilho(String uid) async {
    await firestore.collection('gatilhos').doc(uid).delete();
  }
}
