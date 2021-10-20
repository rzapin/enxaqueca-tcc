import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayMedicamentos extends StatefulWidget {
  List<Medicamento> medicamentos;

  DisplayMedicamentos({
    Key key,
    @required this.medicamentos,
  }) : super(key: key);

  @override
  _DisplayMedicamentosState createState() => _DisplayMedicamentosState();
}

class _DisplayMedicamentosState extends State<DisplayMedicamentos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.medicamentos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.medicamentos[index].nome),
                    ElevatedButton(
                        onPressed: () {
                          _deleteMedicamento(widget.medicamentos[index].id);
                        },
                        child: new Icon(Icons.delete_rounded))
                  ]),
            );
          }),
    );
  }

  _deleteMedicamento(String uid) {
    BlocProvider.of<MedicamentoBloc>(context).add(DeleteMedicamentoEvent(uid));
  }
}
