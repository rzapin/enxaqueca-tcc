import 'dart:core';

import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const Color myBlue = Color(0xef00121d);

class BoxNumeros extends StatefulWidget {
  List<Crise> crises;
  List<Medicamento> medicamentos;
  List<Crise> crisesWithMed;

  BoxNumeros({
    Key key,
    @required this.crises,
    @required this.medicamentos,
    @required this.crisesWithMed,
  }) : super(key: key);

  @override
  _BoxNumerosState createState() => _BoxNumerosState();
}

class _BoxNumerosState extends State<BoxNumeros> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.crises.sort((a, b) => a.diaHoraInicio.compareTo(b.diaHoraInicio));

    return Container(
      color: myBlue,
      child: SizedBox(
        width: 155.0,
        height: 155.0,
        child: Column(
          children: [
            Container(
              color: Colors.black87,
              child: SizedBox(
                width: 155.0,
                height: 44.0,
                child: Center(
                  child: Text("Números"),
                ),
              ),
            ),
            SizedBox(
              width: 155.0,
              height: 22.0,
              child: Center(
                child: Text(
                  'Média de crises mensais: ' +
                      _getMonthlyAverage().toStringAsFixed(2),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            SizedBox(
              width: 155.0,
              height: 22.0,
              child: Center(
                child: Text(
                  'Média de crises semanais: ' +
                      _getWeeklyAverage().toStringAsFixed(2),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            SizedBox(
              width: 155.0,
              height: 22.0,
              child: Center(
                child: Text(
                  'Duração média: ' +
                      _getAverageDuration().toStringAsFixed(1) + ' hs',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMonthlyAverage() {
    int nrCrises = widget.crises.length;
    double nrMeses = widget.crises.last.diaHoraFim
            .difference(widget.crises[0].diaHoraInicio)
            .inDays /
        30;
    return nrCrises / nrMeses;
  }

  double _getWeeklyAverage() {
    int nrCrises = widget.crises.length;
    double nrSemanas = widget.crises.last.diaHoraFim
            .difference(widget.crises[0].diaHoraInicio)
            .inDays /
        7;
    return nrCrises / nrSemanas;
  }

  double _getAverageDuration() {
    double totalTime = 0;

    for (int i = 0; i < widget.crises.length; i++) {
       totalTime += widget.crises[i].diaHoraFim.difference(widget.crises[i].diaHoraInicio).inHours.toDouble();
    }

    return totalTime / widget.crises.length;
  }
}
