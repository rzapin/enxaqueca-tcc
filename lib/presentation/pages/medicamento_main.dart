import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/widgets/display_medicamentos.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'newMedicamento_screen.dart';

class MedicamentoMain extends StatefulWidget {
  @override
  _MedicamentoMainState createState() => _MedicamentoMainState();
}

class _MedicamentoMainState extends State<MedicamentoMain> {
  @override
  void initState() {
    super.initState();

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
        title: Text("Medicamentos"),
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
                      value: BlocProvider.of<MedicamentoBloc>(context),
                      child: NewMedicamentoScreen()),
                ),
              );
            },
            tooltip: 'Novo Registro',
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: Center(
        child: _medBlocBuilder(),
      ),
    );
  }

  _medBlocBuilder() {
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
        builder: (context, state) {
          if (state is MedicamentoLoading) {
            return LoadingWidget();
          } else if (state is MedicamentoLoaded) {
            return Container(
                child: Column(children: <Widget>[
                  DisplayMedicamentos(medicamentos: state.medicamentos),
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
