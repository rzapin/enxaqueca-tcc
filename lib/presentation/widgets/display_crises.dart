import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DisplayCrises extends StatefulWidget {
  List<Crise> crises;
  List<Medicamento> medicamentos;

  DisplayCrises({
    Key key,
    @required this.crises,
    @required this.medicamentos,
  }) : super(key: key);

  @override
  _DisplayCrisesState createState() => _DisplayCrisesState();
}

class _DisplayCrisesState extends State<DisplayCrises> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.crises.length,
          itemBuilder: (BuildContext context, int index) {
            return new ExpansionTile(
              title: Text(
                  DateFormat.MMMd().format(widget.crises[index].diaHoraInicio)),
              children: <Widget>[
                new Column(
                  children: _buildExpandableContent(widget.crises[index]),
                )
              ],
            );
          }),
    );
  }

  _buildExpandableContent(Crise crise) {
    List<Widget> columnContent = [];
    print(crise.medicamento);

    // Medicamento medicamento = crise.medicamento == null
    //     ? new Medicamento(nome: "nenhum", dosagem: 0, codigoCor: " ")
    //     : _getInfosMedicamento(crise.medicamento);

    columnContent.add(
      new ListTile(
        title: new Text("De " +
            DateFormat.Hm().format(crise.diaHoraInicio) +
            " a " +
            DateFormat.Hm().format(crise.diaHoraFim)),
        subtitle: Text("Medicamento: " +
            _getInfosMedicamento(crise.medicamento.toString().substring(53, 73)).nome
                .toString()),
        isThreeLine: true,
        trailing: new IconButton(
          icon: Icon(Icons.delete),
          //   onPressed: _deleteCrise(widget.crises[i].id),
        ),
      ),
    );

    return columnContent;
  }

  Medicamento _getInfosMedicamento(String medUid) {
    final index =
        widget.medicamentos.indexWhere((element) => element.id == medUid);
    return widget.medicamentos[index];
  }

  _deleteCrise(String uid) {
    BlocProvider.of<CriseBloc>(context).add(DeleteCriseEvent(uid));
  }
}
