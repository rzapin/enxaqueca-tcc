import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const Color myBlue = Color(0xef00121d);

class BoxCrises extends StatefulWidget {
  List<Crise> crises;

  BoxCrises({
    Key key,
    @required this.crises,
  }) : super(key: key);

  @override
  _BoxCrisesState createState() => _BoxCrisesState();
}

class _BoxCrisesState extends State<BoxCrises> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Ordena crises por data de inicio
    widget.crises.sort((b, a) => a.diaHoraInicio.compareTo(b.diaHoraInicio));

    List<Widget> crisesMed = List.filled(
        4,
        SizedBox(
          width: 155.0,
          height: 22.0,
          child: Center(
            child: Text(" ", style: TextStyle(fontSize: 9)),
          ),
        ),
        growable: true);

    for (int i = 0; i < widget.crises.length; i++) {
      crisesMed[i] = Container(
        padding: EdgeInsets.all(1.0),
        child: SizedBox(
          width: 155.0,
          height: 22.0,
          child: Text(
            DateFormat.yMd().format(widget.crises[i].diaHoraInicio) +
                " - " +
                widget.crises[i].intensidade.toString(),
            style: TextStyle(fontSize: 9),
            textAlign: TextAlign.left,
          ),
        ),
      );

      if (i == 3) {
        break;
      }
    }

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
                  child: Text(
                    "Últimas crises",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7.0),
              child: Column(children: crisesMed),
            ),
          ],
        ),
      ),
    );
  }
}
