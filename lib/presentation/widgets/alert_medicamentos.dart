import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertMedicamentos extends StatefulWidget {
  List<Medicamento> medicamentos;

  AlertMedicamentos({
    Key key,
    @required this.medicamentos,
  }) : super(key: key);

  @override
  _AlertMedicamentosState createState() => _AlertMedicamentosState();
}

class _AlertMedicamentosState extends State<AlertMedicamentos> {
  @override
  void initState() {
    super.initState();
  }

  var _checked = false;

  Future<void> _showMedicamentoDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.medicamentos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: new CheckboxListTile(
                        title: Text(widget.medicamentos[index].nome + ' ' + widget.medicamentos[index].dosagem.toString() + 'mg'),
                        value: _checked,
                        onChanged: (value) {
                          setState(() {
                            _checked = value;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.medicamentos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text(""),
            );
          }),
    );
  }

  _deleteMedicamento(String uid) {
    BlocProvider.of<MedicamentoBloc>(context).add(DeleteMedicamentoEvent(uid));
  }
}
