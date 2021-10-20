import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMedicamentoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inserir novo medicamento")),
      body: SingleChildScrollView(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Nome:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['nome'] = val;
                      },
                    ),
                  ),
                  Text("Dosagem:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['dosagem'] = val;
                      },
                    ),
                  ),
                  Text("Código Cor:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['codigoCor'] = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Enviar"),
                      onPressed: () {
                        _sendToServer(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendToServer(BuildContext context) {
    _formKey.currentState.save();

    final newMedicamento = Medicamento(
        nome: _formData['nome'],
        dosagem: int.parse(_formData['dosagem']),
        codigoCor: _formData['codigoCor']);

    BlocProvider.of<MedicamentoBloc>(context)
        .add(NewMedicamentoEvent(newMedicamento));

    Navigator.pop(context);
  }
}
