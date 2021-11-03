import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/crise_med/crise_med_bloc.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/bloc/intensidade/intensidade_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:enxaqueca/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  initializeDateFormatting('pt_BR');
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enxacaker',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      themeMode: ThemeMode.dark,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CriseBloc>(
            create: (BuildContext context) => di.sl<CriseBloc>(),
          ),
          BlocProvider<CrisesWithMedBloc>(
            create: (BuildContext context) => di.sl<CrisesWithMedBloc>(),
          ),
          BlocProvider<MedicamentoBloc>(
            create: (BuildContext context) => di.sl<MedicamentoBloc>(),
          ),
          BlocProvider<GatilhoBloc>(
            create: (BuildContext context) => di.sl<GatilhoBloc>(),
          ),
          BlocProvider<SintomaBloc>(
            create: (BuildContext context) => di.sl<SintomaBloc>(),
          ),
          BlocProvider<IntensidadeBloc>(
            create: (BuildContext context) => di.sl<IntensidadeBloc>(),
          ),
        ],
        child: MainPage(),
      ),
    );
  }
}
