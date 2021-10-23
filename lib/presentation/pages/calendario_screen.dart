import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_calendar_rafael/scrollable_clean_calendar.dart';

class CalendarioScreen extends StatefulWidget {
  final List<Crise> crises;

  CalendarioScreen({
    Key key,
    @required this.crises,
  }) : super(key: key);

  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CriseBloc>(context).add(GetAllCrisesEvent());
  }

  Color getHighlight(DateTime date) {
    if (int.parse(date.day.toString()).isEven) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _blocBuilder();
  }

  _blocBuilder() {
    return BlocBuilder<CriseBloc, CriseState>(builder: (context, state) {
      if (state is CriseLoading) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Calendario'),
            ),
            body: LoadingWidget());
      } else if (state is CriseLoaded) {
        List<DateTime> diasCrise = new List.filled(
            state.crises.length, DateTime.now(),
            growable: true);

        for (int i = 0; i < state.crises.length; i++) {
          diasCrise[i] = DateTime.parse(
              DateFormat('yyyy-MM-dd').format(state.crises[i].diaHoraInicio));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Calendario'),
          ),
          body: ScrollableCleanCalendar(
            highlightedDates: diasCrise,
            dateHighlight: (date) {
              return getHighlight(date);
            },
            isRangeMode: false,
            onTapDate: (date) {
              print('onTap $date');
            },
            locale: 'pt',
            initialDateSelected: DateTime.now(),
            minDate: DateTime.parse('2020-01-01 00:00:00.000'),
            maxDate: DateTime.now(),
            renderPostAndPreviousMonthDates: true,
          ),
        );
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'nothing data :(',
            ),
          ],
        ),
      );
    });
  }
}
