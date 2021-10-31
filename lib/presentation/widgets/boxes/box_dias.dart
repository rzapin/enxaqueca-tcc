import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/widgets/mini_calendario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const Color myBlue = Color(0xef00121d);

class BoxDias extends StatefulWidget {
  List<Crise> crises;

  BoxDias({
    Key key,
    @required this.crises,
  }) : super(key: key);

  @override
  _BoxDiasState createState() => _BoxDiasState();
}

class _BoxDiasState extends State<BoxDias> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.crises.sort((b, a) => a.diaHoraInicio.compareTo(b.diaHoraInicio));

    return Container(
      color: myBlue,
      child: Column(
        children: [
          Container(
            color: Colors.black87,
            child: SizedBox(
              width: 155.0,
              height: 44.0,
              child: Center(
                child: Text("Dias sem dor"),
              ),
            ),
          ),
          SizedBox(
            width: 155.0,
            height: 111.0,
            child: Center(
              child: Text(
                _calculateDiasSemCrise(),
                style: TextStyle(fontSize: 64),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDiasSemCrise() {
    if (widget.crises.isNotEmpty) {
      String diasSemCrise = DateTime.now()
          .difference(widget.crises[0].diaHoraFim)
          .inDays
          .toString();
      return diasSemCrise;
    } else {
      return "Não há crises cadastradas";
    }
  }
}
