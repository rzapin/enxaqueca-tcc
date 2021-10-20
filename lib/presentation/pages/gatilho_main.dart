import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/widgets/display_gatilhos.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'newGatilho_screen.dart';

class GatilhoMain extends StatefulWidget {
  @override
  _GatilhoMainState createState() => _GatilhoMainState();
}

class _GatilhoMainState extends State<GatilhoMain> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GatilhoBloc>(context).add(GetAllGatilhosEvent());
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
        title: Text("Gatilhos"),
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
                      value: BlocProvider.of<GatilhoBloc>(context),
                      child: NewGatilhoScreen()),
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
    return BlocBuilder<GatilhoBloc, GatilhoState>(
        builder: (context, state) {
          if (state is GatilhoLoading) {
            return LoadingWidget();
          } else if (state is GatilhoLoaded) {
            return Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  DisplayGatilhos(gatilhos: state.gatilhos),
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
