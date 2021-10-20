import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSintomaScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inserir novo sintoma")),
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
                  Text("Hora de início:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['horaInicio'] = val;
                      },
                    ),
                  ),
                  Text("Hora de fim:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['horaFim'] = val;
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

    final newSintoma = Sintoma(
      nome: _formData['nome'],
      horaInicio: DateTime.parse((_formData['horaInicio'])),
      horaFim: DateTime.parse((_formData['horaFim'])),
    );

    BlocProvider.of<SintomaBloc>(context).add(NewSintomaEvent(newSintoma));

    Navigator.pop(context);
  }
}
