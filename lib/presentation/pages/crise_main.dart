import 'package:enxaqueca/injection_container.dart' as di;
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:enxaqueca/presentation/widgets/display_crises.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'newCrise_screen.dart';

class CriseMain extends StatefulWidget {
  @override
  _CriseMainState createState() => _CriseMainState();
}

class _CriseMainState extends State<CriseMain> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CriseBloc>(context).add(GetAllCrisesEvent());
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
        title: Text("Crises"),
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
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<CriseBloc>(
                        create: (BuildContext context) => di.sl<CriseBloc>(),
                      ),
                      BlocProvider<MedicamentoBloc>(
                        create: (BuildContext context) =>
                            di.sl<MedicamentoBloc>(),
                      ),
                      BlocProvider<GatilhoBloc>(
                        create: (BuildContext context) =>
                            di.sl<GatilhoBloc>(),
                      ),
                      BlocProvider<SintomaBloc>(
                        create: (BuildContext context) =>
                            di.sl<SintomaBloc>(),
                      ),
                    ],
                    child: NewCriseScreen(),
                  ),
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
    return BlocBuilder<CriseBloc, CriseState>(
        builder: (context, state) {
          if (state is CriseLoading) {
            return LoadingWidget();
          } else if (state is CriseLoaded) {
            return Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  DisplayCrises(crises: state.crises),
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
