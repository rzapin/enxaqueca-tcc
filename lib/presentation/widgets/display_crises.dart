import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    if (widget.crises.isNotEmpty) {
      //Ordena por data de inicio
      widget.crises.sort((a, b) => a.diaHoraInicio.compareTo(b.diaHoraInicio));

      return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.crises.length,
            itemBuilder: (BuildContext context, int index) {
              String medId = widget.crises[index].medicamento == null
                  ? "1"
                  : widget.crises[index].medicamento;

              return new Dismissible(
                key: ValueKey(index),
                child: ExpansionTile(
                  title: Text(
                    DateFormat.yMMMMd('pt_BR')
                        .format(widget.crises[index].diaHoraInicio),
                  ),
                  children: <Widget>[
                    new Column(
                      children:
                          _buildExpandableContent(widget.crises[index], medId),
                    )
                  ],
                ),
                onDismissed: (direction) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Deseja excluir essa crise?"),
                      content: Text(
                        DateFormat.yMMMMd('pt_BR')
                                .format(widget.crises[index].diaHoraInicio) +
                            ", de " +
                            DateFormat.Hm().format(widget.crises[index].diaHoraInicio) +
                            " a " +
                            DateFormat.Hm()
                                .format(widget.crises[index].diaHoraFim),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Não"),
                        ),
                        TextButton(
                          onPressed: () {
                            _deleteCrise(widget.crises[index].id);
                          },
                          child: Text("Sim"),
                        ),
                      ],
                    ),
                  );
                },
                background:
                    Container(color: Colors.red, child: Icon(Icons.delete)),
              );
            }),
      );
    } else
      return Center(
        child: Text(
          "Você ainda não tem crises cadastradas",
          style: TextStyle(fontSize: 24, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
  }

  _buildExpandableContent(Crise crise, String medId) {
    List<Widget> columnContent = [];

    if (crise.medicamento == null) {
      columnContent.add(
        new ListTile(
          title: new Text("De " +
              DateFormat.Hm().format(crise.diaHoraInicio) +
              " a " +
              DateFormat.Hm().format(crise.diaHoraFim) +
              " (" +
              crise.diaHoraFim
                  .difference(crise.diaHoraInicio)
                  .inHours
                  .toString() +
              ' hs)' +
              " - Intensidade: " +
              crise.intensidade.toString()),
          subtitle: Text("Nenhum medicamento tomado"),
          isThreeLine: true,
          dense: true,
          trailing: new IconButton(
            icon: Icon(Icons.delete),
            //   onPressed: _deleteCrise(widget.crises[i].id),
          ),
        ),
      );
    } else {
      columnContent.add(
        new ListTile(
          title: new Text("De " +
              DateFormat.Hm().format(crise.diaHoraInicio) +
              " a " +
              DateFormat.Hm().format(crise.diaHoraFim) +
              " (" +
              crise.diaHoraFim
                  .difference(crise.diaHoraInicio)
                  .inHours
                  .toString() +
              ' hs)' +
              " - Intensidade: " +
              crise.intensidade.toString()),
          subtitle: Text("Medicamento: " +
              _getInfosMedicamento(medId).nome.toString() +
              " " +
              _getInfosMedicamento(medId).dosagem.toString() +
              " mg"),
          isThreeLine: true,
          dense: true,
          trailing: new IconButton(
            icon: Icon(Icons.delete),
            //   onPressed: _deleteCrise(widget.crises[i].id),
          ),
        ),
      );
    }

    return columnContent;
  }

  Medicamento _getInfosMedicamento(String medUid) {
    final index =
        widget.medicamentos.indexWhere((element) => element.id == medUid);
    if (index == -1) {
      return new Medicamento(nome: "nenhum");
    }
    return widget.medicamentos[index];
  }

  _deleteCrise(String uid) {
    BlocProvider.of<CriseBloc>(context).add(DeleteCriseEvent(uid));
  }
}
