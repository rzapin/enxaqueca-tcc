import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/intensidade/intensidade_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/widgets/alert_crise.dart';
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
    BlocProvider.of<IntensidadeBloc>(context).add(GetAllIntensidadesEvent());
    BlocProvider.of<MedicamentoBloc>(context).add(GetAllMedicamentosEvent());
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
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
      builder: (context, state) {
        if (state is MedicamentoLoading) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Calendario'),
              ),
              body: LoadingWidget());
        } else if (state is MedicamentoLoaded) {
          List<Medicamento> medicamentos = state.medicamentos;

          Medicamento _getInfosMedicamento(String medUid) {
            final index =
                medicamentos.indexWhere((element) => element.id == medUid);
            if (index == -1) {
              return new Medicamento(nome: "nenhum");
            }
            return medicamentos[index];
          }

          return BlocBuilder<IntensidadeBloc, IntensidadeState>(
            builder: (context, state) {
              if (state is IntensidadeLoading) {
                return Scaffold(
                    appBar: AppBar(
                      title: Text('Calendario'),
                    ),
                    body: LoadingWidget());
              } else if (state is IntensidadeLoaded) {
                List<Intensidade> intensidades = state.intensidades;

                return BlocBuilder<CriseBloc, CriseState>(
                    builder: (context, state) {
                  if (state is CriseLoading) {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text('Calendario'),
                        ),
                        body: LoadingWidget());
                  } else if (state is CriseLoaded) {
                    //Ordena crises por data de inicio
                    state.crises.sort(
                        (a, b) => a.diaHoraInicio.compareTo(b.diaHoraInicio));

                    Color getHighlightColor(DateTime date, int intensidade) {
                      final index = intensidades.indexWhere(
                          (element) => element.intensidade == intensidade);
                      int color = int.parse(
                          '0xE7' + intensidades[index].codigoCor.toString());
                      return Color(color);
                    }

                    List<DateTime> diasCrise = new List.filled(
                        state.crises.length, DateTime.now(),
                        growable: true);

                    for (int i = 0; i < state.crises.length; i++) {
                      diasCrise[i] = DateTime.parse(DateFormat('yyyy-MM-dd')
                          .format(state.crises[i].diaHoraInicio));
                    }

                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Calendario'),
                      ),
                      body: ScrollableCleanCalendar(
                        highlightedDates: diasCrise,
                        dateHighlight: (date) {
                          final index = state.crises.indexWhere((element) =>
                              DateFormat.yMd().format(element.diaHoraInicio) ==
                              DateFormat.yMd().format(date));
                          return getHighlightColor(
                              date, state.crises[index].intensidade);
                        },
                        isRangeMode: false,
                        onTapDate: (date) {
                          final index = state.crises.indexWhere((element) =>
                              DateFormat.yMd().format(element.diaHoraInicio) ==
                              DateFormat.yMd().format(date));
                          if (index == -1) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Não há crise para este dia."),
                              ),
                            );
                          } else {
                            String medUid = state.crises[index].medicamento;

                            showDialog(
                              context: context,
                              builder: (_) => AlertCrise(
                                crise: state.crises[index],
                                medicamento: _getInfosMedicamento(medUid),
                              ),
                            );
                          }
                        },
                        locale: 'pt',
                        minDate: state.crises[0].diaHoraInicio,
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
            },
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
      },
    );
  }
}
