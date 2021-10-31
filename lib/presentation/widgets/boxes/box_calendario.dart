import 'package:enxaqueca/presentation/widgets/mini_calendario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color myBlue = Color(0xef00121d);

class BoxCalendario extends StatefulWidget {
  BoxCalendario({
    Key key,
  }) : super(key: key);

  @override
  _BoxCalendarioState createState() => _BoxCalendarioState();
}

class _BoxCalendarioState extends State<BoxCalendario> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: myBlue,
            child: SizedBox(
              width: 320.0,
              height: 155.0,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.black87,
                        child: SizedBox(
                          width: 155.0,
                          height: 44.0,
                          child: Center(
                            child: Text(DateFormat.EEEE()
                                .format(DateTime.now())
                                .toString()
                                .capitalize()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 155.0,
                        height: 111.0,
                        child: Center(
                          child: Text(
                            DateTime.now().day.toString(),
                            style: TextStyle(fontSize: 64),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 155.0,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black87,
                          child: SizedBox(
                            width: 10.0,
                            height: 44.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 155.0,
                    height: 155.0,
                    child: MiniCalendario(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
