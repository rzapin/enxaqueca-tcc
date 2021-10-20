import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:enxaqueca/presentation/widgets/display_sintomas.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'newSintoma_screen.dart';

class SintomaMain extends StatefulWidget {
  @override
  _SintomaMainState createState() => _SintomaMainState();
}

class _SintomaMainState extends State<SintomaMain> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SintomaBloc>(context).add(GetAllSintomasEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        titleTextStyle: new TextStyle(
            fontSize: 16, fontFamily: "Helvetica", fontWeight: FontWeight.bold),
        title: Text("Sintomas"),
      ),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.00,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<SintomaBloc>(context),
                      child: NewSintomaScreen()),
                ),
              );
            },
            tooltip: 'Novo Registro',
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: Center(
        child: _blocBuilder(),
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<SintomaBloc, SintomaState>(
        builder: (context, state) {
          if (state is SintomaLoading) {
            return LoadingWidget();
          } else if (state is SintomaLoaded) {
            return Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  DisplaySintomas(sintomas: state.sintomas),
                ]));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'nothing data :(',
                ),
              ],
            ),
          );
        });
  }

  void dispatchRandom() {
    print('dispatchRandom');
  }
}
