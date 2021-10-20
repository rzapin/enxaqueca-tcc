import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DisplayCrises extends StatefulWidget {
  List<Crise> crises;

  DisplayCrises({
    Key key,
    @required this.crises,
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
            return Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(DateFormat.MMMd().format(widget.crises[index].diaHoraInicio)),
                    ElevatedButton(
                        onPressed: () {
                          _deleteCrise(widget.crises[index].id);
                        },
                        child: new Icon(Icons.delete_rounded))
                  ]),
            );
          }),
    );
  }

  _deleteCrise(String uid) {
    BlocProvider.of<CriseBloc>(context).add(DeleteCriseEvent(uid));
  }
}
