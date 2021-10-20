import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplaySintomas extends StatefulWidget {
  List<Sintoma> sintomas;

  DisplaySintomas({
    Key key,
    @required this.sintomas,
  }) : super(key: key);

  @override
  _DisplaySintomasState createState() => _DisplaySintomasState();
}

class _DisplaySintomasState extends State<DisplaySintomas> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.sintomas.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.sintomas[index].nome),
                    ElevatedButton(
                        onPressed: () {
                          _deleteSintoma(widget.sintomas[index].id);
                        },
                        child: new Icon(Icons.delete_rounded))
                  ]),
            );
          }),
    );
  }

  _deleteSintoma(String uid) {
    BlocProvider.of<SintomaBloc>(context).add(DeleteSintomaEvent(uid));
  }
}
