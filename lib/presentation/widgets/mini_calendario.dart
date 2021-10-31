import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:core';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

const Color myBlue = Color(0xef00121d);

class MiniCalendario extends StatefulWidget {
  MiniCalendario({
    Key key,
  }) : super(key: key);

  @override
  _MiniCalendarioState createState() => _MiniCalendarioState();
}

class _MiniCalendarioState extends State<MiniCalendario> {
  @override
  void initState() {
    super.initState();
  }

  final int thisYear = DateTime.now().year;
  final int thisMonth = DateTime.now().month;

  List<Widget> dias1 = List.filled(
    7,
    SizedBox(
      width: 22.0,
      height: 22.0,
      child: Center(
        child: Text(' ', style: TextStyle(fontSize: 9)),
      ),
    ),
  );

  List<Widget> dias2 = List.filled(
    7,
    SizedBox(
      width: 22.0,
      height: 22.0,
      child: Center(
        child: Text(' ', style: TextStyle(fontSize: 9)),
      ),
    ),
  );

  List<Widget> dias3 = List.filled(
    7,
    SizedBox(
      width: 22.0,
      height: 22.0,
      child: Center(
        child: Text(' ', style: TextStyle(fontSize: 9)),
      ),
    ),
  );

  List<Widget> dias4 = List.filled(
    7,
    SizedBox(
      width: 22.0,
      height: 22.0,
      child: Center(
        child: Text(' ', style: TextStyle(fontSize: 9)),
      ),
    ),
  );

  List<Widget> dias5 = List.filled(
    7,
    SizedBox(
      width: 22.0,
      height: 22.0,
      child: Center(
        child: Text(' ', style: TextStyle(fontSize: 9)),
      ),
    ),
  );

  int lastDay = 0;

  @override
  Widget build(BuildContext context) {
    int firstWeekDayMonth = DateTime.utc(thisYear, thisMonth, 1).weekday;
    int lastWeekDayMonth = DateTime.utc(thisYear, thisMonth + 1, 0).weekday;

    int diaCount = 0;

    for (int i = firstWeekDayMonth; i <= 7; i++) {
      diaCount++;
      dias1[i - 1] = SizedBox(
        width: 22.0,
        height: 22.0,
        child: Center(
          child: Text(diaCount.toString(), style: TextStyle(fontSize: 9)),
        ),
      );
    }

    for (int i = 0; i <= 6; i++) {
      diaCount++;
      dias2[i] = SizedBox(
        width: 22.0,
        height: 22.0,
        child: Center(
          child: Text(diaCount.toString(), style: TextStyle(fontSize: 9)),
        ),
      );
    }

    for (int i = 0; i <= 6; i++) {
      diaCount++;
      dias3[i] = SizedBox(
        width: 22.0,
        height: 22.0,
        child: Center(
          child: Text(diaCount.toString(), style: TextStyle(fontSize: 9)),
        ),
      );
    }

    for (int i = 0; i <= 6; i++) {
      diaCount++;
      dias4[i] = SizedBox(
        width: 22.0,
        height: 22.0,
        child: Center(
          child: Text(diaCount.toString(), style: TextStyle(fontSize: 9)),
        ),
      );
    }

    for (int i = 0; i <= lastWeekDayMonth - 1; i++) {
      diaCount++;
      dias5[i] = SizedBox(
        width: 22.0,
        height: 22.0,
        child: Center(
          child: Text(diaCount.toString(), style: TextStyle(fontSize: 9)),
        ),
      );
    }

    return Container(
      child: SizedBox(
        width: 155.0,
        height: 155.0,
        child: Column(
          children: [
            Container(
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat.MMMM().format(DateTime.now()).capitalize() +
                          ', ' +
                          thisYear.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('s', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('t', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('q', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('q', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('s', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('s', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Center(
                      child: Text('d', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              dias1[0],
              dias1[1],
              dias1[2],
              dias1[3],
              dias1[4],
              dias1[5],
              dias1[6]
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              dias2[0],
              dias2[1],
              dias2[2],
              dias2[3],
              dias2[4],
              dias2[5],
              dias2[6],
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              dias3[0],
              dias3[1],
              dias3[2],
              dias3[3],
              dias3[4],
              dias3[5],
              dias3[6],
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              dias4[0],
              dias4[1],
              dias4[2],
              dias4[3],
              dias4[4],
              dias4[5],
              dias4[6],
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              dias5[0],
              dias5[1],
              dias5[2],
              dias5[3],
              dias5[4],
              dias5[5],
              dias5[6],
            ]),
          ],
        ),
      ),
    );
  }
}
