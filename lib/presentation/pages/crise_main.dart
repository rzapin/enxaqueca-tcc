import 'package:enxaqueca/domain/entities/medicamento.dart';
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
    BlocProvider.of<MedicamentoBloc>(context).add(GetAllMedicamentosEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crises"),
      ),
      body: Center(
        child: _blocBuilder(),
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
      builder: (context, state) {
        if (state is MedicamentoLoading) {
          return LoadingWidget();
        } else if (state is MedicamentoLoaded) {
          List<Medicamento> medicamentos = state.medicamentos;

          return BlocBuilder<CriseBloc, CriseState>(
            builder: (context, state) {
              if (state is CriseLoading) {
                return LoadingWidget();
              } else if (state is CriseLoaded) {
                return Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                  DisplayCrises(crises: state.crises, medicamentos: medicamentos,),
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
            },
          );
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
      },
    );
  }

  void dispatchRandom() {
    print('dispatchRandom');
  }
}
