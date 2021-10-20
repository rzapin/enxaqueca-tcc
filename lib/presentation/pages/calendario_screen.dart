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
        return MaterialApp(
          title: 'Scrollable clean calendar',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
              appBar: AppBar(
                title: Text('ScrollableCleanCalendar'),
              ),
              body: LoadingWidget()),
        );
      } else if (state is CriseLoaded) {
          List<DateTime> diasCrise = new List.filled(state.crises.length, DateTime.now(), growable: true);

          for (int i = 0; i < state.crises.length; i++) {
            diasCrise[i] = DateTime.parse(DateFormat('yyyy-MM-dd').format(state.crises[i].diaHoraInicio));
          }

        return MaterialApp(
          title: 'Scrollable clean calendar',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text('ScrollableCleanCalendar'),
            ),
            body: ScrollableCleanCalendar(
              highlightedDates: diasCrise,
              dateHighlight: (date) {
                return getHighlight(date);
              },
              isRangeMode: false,
              onRangeSelected: (firstDate, secondDate) {
                print('onRangeSelected first $firstDate');
                print('onRangeSelected second $secondDate');
              },
              onTapDate: (date) {
                print('onTap $date');
              },
              locale: 'pt',
              //default is en
              minDate: DateTime.now(),
              maxDate: DateTime.now().add(
                Duration(days: 365),
              ),
              renderPostAndPreviousMonthDates: true,
            ),
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