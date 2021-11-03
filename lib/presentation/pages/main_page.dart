import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/injection_container.dart' as di;
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/crise_med/crise_med_bloc.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/bloc/intensidade/intensidade_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:enxaqueca/presentation/pages/newCrise_screen.dart';
import 'package:enxaqueca/presentation/pages/sintoma_main.dart';
import 'package:enxaqueca/presentation/widgets/boxes/box_calendario.dart';
import 'package:enxaqueca/presentation/widgets/boxes/box_crises.dart';
import 'package:enxaqueca/presentation/widgets/boxes/box_dias.dart';
import 'package:enxaqueca/presentation/widgets/boxes/box_medicamentos.dart';
import 'package:enxaqueca/presentation/widgets/boxes/box_numeros.dart';
import 'package:enxaqueca/presentation/widgets/display_crises.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'calendario_screen.dart';
import 'crise_main.dart';
import 'gatilho_main.dart';
import 'medicamento_main.dart';

const Color myBlue = Color(0xef00121d);

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';

    BlocProvider.of<MedicamentoBloc>(context).add(GetAllMedicamentosEvent());
    BlocProvider.of<CriseBloc>(context).add(GetAllCrisesEvent());
    BlocProvider.of<CrisesWithMedBloc>(context).add(GetCrisesWithMedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: new TextStyle(
            fontSize: 20, fontFamily: "Helvetica", fontWeight: FontWeight.bold),
        title: Text("Diário de Enxaqueca"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider<CriseBloc>(
                              create: (BuildContext context) =>
                                  di.sl<CriseBloc>(),
                            ),
                            BlocProvider<MedicamentoBloc>(
                              create: (BuildContext context) =>
                                  di.sl<MedicamentoBloc>(),
                            ),
                            BlocProvider<IntensidadeBloc>(
                              create: (BuildContext context) =>
                                  di.sl<IntensidadeBloc>(),
                            ),
                          ],
                          child: CalendarioScreen(),
                        ),
                      ),
                    );
                  },
                  child: BoxCalendario(),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<CriseBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<CriseBloc>(),
                                  ),
                                  BlocProvider<MedicamentoBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<MedicamentoBloc>(),
                                  ),
                                  BlocProvider<IntensidadeBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<IntensidadeBloc>(),
                                  ),
                                ],
                                child: CalendarioScreen(),
                              ),
                            ),
                          );
                          setState(() {
                            BlocProvider.of<MedicamentoBloc>(context)
                                .add(GetAllMedicamentosEvent());
                            BlocProvider.of<CriseBloc>(context)
                                .add(GetAllCrisesEvent());
                            BlocProvider.of<CrisesWithMedBloc>(context)
                                .add(GetCrisesWithMedEvent());
                          });
                        },
                        child: _diasBoxBlocBuilder(),
                      ),
                      SizedBox(
                        width: 10.0,
                        height: 155.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<CriseBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<CriseBloc>(),
                                  ),
                                  BlocProvider<MedicamentoBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<MedicamentoBloc>(),
                                  ),
                                  BlocProvider<IntensidadeBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<IntensidadeBloc>(),
                                  ),
                                ],
                                child: CriseMain(),
                              ),
                            ),
                          );
                          setState(() {
                            BlocProvider.of<MedicamentoBloc>(context)
                                .add(GetAllMedicamentosEvent());
                            BlocProvider.of<CriseBloc>(context)
                                .add(GetAllCrisesEvent());
                            BlocProvider.of<CrisesWithMedBloc>(context)
                                .add(GetCrisesWithMedEvent());
                          });
                        },
                        child: _criseBoxBlocBuilder(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<CriseBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<CriseBloc>(),
                                  ),
                                  BlocProvider<MedicamentoBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<MedicamentoBloc>(),
                                  ),
                                  BlocProvider<IntensidadeBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<IntensidadeBloc>(),
                                  ),
                                ],
                                child: MedicamentoMain(),
                              ),
                            ),
                          );
                          setState(() {
                            BlocProvider.of<MedicamentoBloc>(context)
                                .add(GetAllMedicamentosEvent());
                            BlocProvider.of<CriseBloc>(context)
                                .add(GetAllCrisesEvent());
                            BlocProvider.of<CrisesWithMedBloc>(context)
                                .add(GetCrisesWithMedEvent());
                          });
                        },
                        child: _medBoxBlocBuilder(),
                      ),
                      SizedBox(
                        width: 10.0,
                        height: 155.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<CriseBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<CriseBloc>(),
                                  ),
                                  BlocProvider<MedicamentoBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<MedicamentoBloc>(),
                                  ),
                                  BlocProvider<IntensidadeBloc>(
                                    create: (BuildContext context) =>
                                        di.sl<IntensidadeBloc>(),
                                  ),
                                ],
                                child: CalendarioScreen(),
                              ),
                            ),
                          );
                          setState(() {
                            BlocProvider.of<MedicamentoBloc>(context)
                                .add(GetAllMedicamentosEvent());
                            BlocProvider.of<CriseBloc>(context)
                                .add(GetAllCrisesEvent());
                            BlocProvider.of<CrisesWithMedBloc>(context)
                                .add(GetCrisesWithMedEvent());
                          });
                        },
                        child: _nrsBoxBlocBuilder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<CriseBloc>(
                    create: (BuildContext context) => di.sl<CriseBloc>(),
                  ),
                  BlocProvider<MedicamentoBloc>(
                    create: (BuildContext context) => di.sl<MedicamentoBloc>(),
                  ),
                ],
                child: NewCriseScreen(),
              ),
            ),
          );
        },
        tooltip: 'Nova crise',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-form
    );
  }

  _diasBoxBlocBuilder() {
    return BlocBuilder<CriseBloc, CriseState>(
      builder: (context, state) {
        if (state is CriseLoading) {
          return LoadingWidget();
        } else if (state is CriseLoaded) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BoxDias(
                  crises: state.crises,
                ),
              ],
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
      },
    );
  }

  _criseBoxBlocBuilder() {
    return BlocBuilder<CriseBloc, CriseState>(
      builder: (context, state) {
        if (state is CriseLoading) {
          return LoadingWidget();
        } else if (state is CriseLoaded) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BoxCrises(
                  crises: state.crises,
                ),
              ],
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
      },
    );
  }

  _medBoxBlocBuilder() {
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
      builder: (context, state) {
        if (state is MedicamentoLoading) {
          return LoadingWidget();
        } else if (state is MedicamentoLoaded) {
          List<Medicamento> medicamentos = state.medicamentos;

          return BlocBuilder<CrisesWithMedBloc, CrisesWithMedState>(
            builder: (context, state) {
              if (state is CrisesWithMedLoading) {
                return LoadingWidget();
              } else if (state is CrisesWithMedLoaded) {
                return Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      BoxMedicamentos(
                        crisesWithMed: state.crisesWithMed,
                        medicamentos: medicamentos,
                      ),
                    ]));
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

  _nrsBoxBlocBuilder() {
    return BlocBuilder<CrisesWithMedBloc, CrisesWithMedState>(
      builder: (context, state) {
        if (state is CrisesWithMedLoading) {
          return LoadingWidget();
        } else if (state is CrisesWithMedLoaded) {
          List<Crise> crisesWithMed = state.crisesWithMed;

          return BlocBuilder<MedicamentoBloc, MedicamentoState>(
            builder: (context, state) {
              if (state is MedicamentoLoading) {
                return LoadingWidget();
              } else if (state is MedicamentoLoaded) {
                List<Medicamento> medicamentos = state.medicamentos;

                return BlocBuilder<CriseBloc, CriseState>(
                  builder: (context, state) {
                    if (state is CriseLoading) {
                      return LoadingWidget();
                    } else if (state is CriseLoaded) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            BoxNumeros(
                                crises: state.crises,
                                medicamentos: medicamentos,
                                crisesWithMed: crisesWithMed),
                          ],
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
