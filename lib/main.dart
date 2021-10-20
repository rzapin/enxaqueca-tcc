import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:enxaqueca/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enxacaker',
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.blueGrey, displayColor: Colors.blueGrey),
        primaryColor: Colors.blueAccent,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CriseBloc>(
            create: (BuildContext context) => di.sl<CriseBloc>(),
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
        ],
        child: MainPage(),
      ),
    );
  }
}
