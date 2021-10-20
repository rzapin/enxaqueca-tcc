import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectMedicamento extends StatefulWidget {
  List<Medicamento> medicamentos;

  SelectMedicamento({
    Key key,
    @required this.medicamentos,
  }) : super(key: key);

  @override
  _SelectMedicamentoState createState() => _SelectMedicamentoState();
}

class _SelectMedicamentoState extends State<SelectMedicamento> {
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
                    CheckboxListTile(
                      title: Text(widget.medicamentos[index].nome),
                      onChanged: (_) =>
                          _getMedicamento(widget.medicamentos[index].id),
                    ),
                  ]),
            );
          }),
    );
  }

  _getMedicamento(String uid) {
    BlocProvider.of<MedicamentoBloc>(context).add(GetMedicamentoEvent(uid));
  }
}
