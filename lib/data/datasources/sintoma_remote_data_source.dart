import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/data/models/sintoma_model.dart';
import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:meta/meta.dart';

abstract class SintomaRemoteDataSource {
  Future<List<SintomaModel>> getAllSintomas();

  Future<SintomaModel> getSintoma(String uid);

  Future<String> newSintoma(Sintoma sintoma);

  Future<void> deleteSintoma(String uid);
}

class SintomaRemoteDataSourceImpl implements SintomaRemoteDataSource {
  final FirebaseFirestore firestore;

  SintomaRemoteDataSourceImpl({@required this.firestore});

  @override
  Future<List<SintomaModel>> getAllSintomas() async {
    var result = await firestore.collection('sintomas').get();

    List<SintomaModel> listSintomaModel = result.docs
        .map((doc) => SintomaModel(
              id: doc.id,
              nome: doc.get('nome'),
              horaInicio: doc.get('horaInicio').toDate(),
              horaFim: doc.get('horaFim').toDate(),
              //  userId: doc.get('userId')
            ))
        .toList();

    return listSintomaModel;
  }

  @override
  Future<SintomaModel> getSintoma(String uid) async {
    Map<String, dynamic> data =
        (await firestore.collection('sintomas').doc(uid).get()).data();

    return SintomaModel.fromJson(data);
  }

  @override
  Future<String> newSintoma(Sintoma sintoma) async {
    final docRef = firestore.collection("sintomas").add({
      'nome': sintoma.nome,
      'horaInicio': sintoma.horaInicio,
      'horaFim': sintoma.horaFim,
      //'userId': sintoma.userId
    });
    return docRef.toString();
  }

  @override
  Future<void> deleteSintoma(String uid) async {
    await firestore.collection('sintomas').doc(uid).delete();
  }
}
