import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayGatilhos extends StatefulWidget {
  List<Gatilho> gatilhos;

  DisplayGatilhos({
    Key key,
    @required this.gatilhos,
  }) : super(key: key);

  @override
  _DisplayGatilhosState createState() => _DisplayGatilhosState();
}

class _DisplayGatilhosState extends State<DisplayGatilhos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.gatilhos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.gatilhos[index].nome),
                    ElevatedButton(
                        onPressed: () {
                          _deleteGatilho(widget.gatilhos[index].id);
                        },
                        child: new Icon(Icons.delete_rounded))
                  ]),
            );
          }),
    );
  }

  _deleteGatilho(String uid) {
    BlocProvider.of<GatilhoBloc>(context).add(DeleteGatilhoEvent(uid));
  }
}
