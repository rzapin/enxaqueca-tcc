import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AlertCrise extends StatefulWidget {
  final Crise crise;
  final Medicamento medicamento;

  AlertCrise({
    Key key,
    @required this.crise,
    @required this.medicamento,
  }) : super(key: key);

  @override
  _AlertCriseState createState() => _AlertCriseState();
}

class _AlertCriseState extends State<AlertCrise> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.medicamento.id == null) {
      return AlertDialog(
        title: Text(
          "Crise do dia " +
              DateFormat.yMMMMd('pt_BR').format(widget.crise.diaHoraInicio),
        ),
        content: Text("De " +
            DateFormat.Hm().format(widget.crise.diaHoraInicio) +
            " a " +
            DateFormat.Hm().format(widget.crise.diaHoraFim) +
            '\n' +
            "Duração: " +
            widget.crise.diaHoraFim
                .difference(widget.crise.diaHoraInicio)
                .inHours
                .toString() +
            " hs\n" +
            "Intensidade: " +
            widget.crise.intensidade.toString() +
            "\n" +
            "Nenhum medicamento tomado"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(
          "Crise do dia " +
              DateFormat.yMMMMd('pt_BR').format(widget.crise.diaHoraInicio),
        ),
        content: Text("De " +
            DateFormat.Hm().format(widget.crise.diaHoraInicio) +
            " a " +
            DateFormat.Hm().format(widget.crise.diaHoraFim) +
            '\n' +
            "Duração: " +
            widget.crise.diaHoraFim
                .difference(widget.crise.diaHoraInicio)
                .inHours
                .toString() +
            " hs\n" +
            "Intensidade: " +
            widget.crise.intensidade.toString() +
            "\n" +
            "Medicamento: " +
            widget.medicamento.nome +
            " " +
            widget.medicamento.dosagem.toString() +
            " mg"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      );
    }
  }
}
