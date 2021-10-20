import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewGatilhoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inserir novo gatilho")),
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
                  Text("Dia e Hora:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['diaHora'] = val;
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

    final newGatilho = Gatilho(
      nome: _formData['nome'],
      diaHora: DateTime.parse((_formData['diaHora'])),
    );

    BlocProvider.of<GatilhoBloc>(context).add(NewGatilhoEvent(newGatilho));

    Navigator.pop(context);
  }
}
