import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/data/models/medicamento_model.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:meta/meta.dart';

abstract class MedicamentoRemoteDataSource {
  Future<List<MedicamentoModel>> getAllMedicamentos();
  Future<MedicamentoModel> getMedicamento(String uid);
  Future<String> newMedicamento(Medicamento medicamento);
  Future<void> deleteMedicamento(String uid);
}

class MedicamentoRemoteDataSourceImpl implements MedicamentoRemoteDataSource {
  final FirebaseFirestore firestore;

  MedicamentoRemoteDataSourceImpl({@required this.firestore});

  @override
  Future<List<MedicamentoModel>> getAllMedicamentos() async {
    var result = await firestore.collection('medicamentos').get();

    List<MedicamentoModel> listMedicamentoModel = result.docs
        .map((doc) => MedicamentoModel(
              id: doc.id,
              nome: doc.get('nome'),
              dosagem: doc.get('dosagem'),
              codigoCor: doc.get('codigoCor'),
            //  userId: doc.get('userId')
            ))
        .toList();

    return listMedicamentoModel;
  }

  @override
  Future<List<MedicamentoModel>> getNomeMedicamentos() async {
    var result = await firestore.collection('medicamentos').get();

    List<MedicamentoModel> listMedicamentoModel = result.docs
        .map((doc) => MedicamentoModel(
    //  id: doc.id,
      nome: doc.get('nome'),
     // dosagem: doc.get('dosagem'),
     // codigoCor: doc.get('codigoCor'),
      //  userId: doc.get('userId')
    ))
        .toList();

    return listMedicamentoModel;
  }

  @override
  Future<MedicamentoModel> getMedicamento(String uid) async {
    Map<String, dynamic> data =
        (await firestore.collection('medicamentos').doc(uid).get()).data();

    return MedicamentoModel.fromJson(data);
  }

  @override
  Future<String> newMedicamento(Medicamento medicamento) async {
    final docRef = firestore.collection("medicamentos").add({
      'nome': medicamento.nome,
      'dosagem': medicamento.dosagem,
      'codigoCor': medicamento.codigoCor,
     // 'userId': medicamento.userId
    });
    return docRef.toString();
  }

  @override
  Future<void> deleteMedicamento(String uid) async {
    await firestore.collection('medicamentos').doc(uid).delete();
  }
}
