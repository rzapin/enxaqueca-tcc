import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/widgets/select_medicamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_widget.dart';


class MedicamentoDialog extends StatefulWidget {
  @override
  _MedicamentoDialogState createState() => _MedicamentoDialogState();
}

class _MedicamentoDialogState extends State<MedicamentoDialog> {
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
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: _BlocBuilder(),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _BlocBuilder() {
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
      builder: (context, state) {
        if (state is MedicamentoLoading) {
          return LoadingWidget();
        } else if (state is MedicamentoLoaded) {
          return Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: Column(children: <Widget>[
                SelectMedicamento(medicamentos: state.medicamentos),
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
}
