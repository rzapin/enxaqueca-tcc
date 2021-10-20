import 'package:enxaqueca/injection_container.dart' as di;
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/gatilho/gatilho_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/bloc/sintoma/sintoma_bloc.dart';
import 'package:enxaqueca/presentation/pages/newCrise_screen.dart';
import 'package:enxaqueca/presentation/pages/sintoma_main.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendario_screen.dart';
import 'crise_main.dart';
import 'gatilho_main.dart';
import 'medicamento_main.dart';


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

    BlocProvider.of<CriseBloc>(context).add(GetAllCrisesEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueGrey,
        titleTextStyle: new TextStyle(
            fontSize: 16, fontFamily: "Helvetica", fontWeight: FontWeight.bold),
        title: Text("Enxaqueca"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<MedicamentoBloc>(context),
                        child: MedicamentoMain()),
                  ),
                );
              },
              child: const Text('Medicamento'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<GatilhoBloc>(context),
                        child: GatilhoMain()),
                  ),
                );
              },
              child: const Text('Gatilho'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<SintomaBloc>(context),
                        child: SintomaMain()),
                  ),
                );
              },
              child: const Text('Sintoma'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
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
                          create: (BuildContext context) =>
                              di.sl<MedicamentoBloc>(),
                        ),
                        BlocProvider<GatilhoBloc>(
                          create: (BuildContext context) =>
                              di.sl<GatilhoBloc>(),
                        ),
                        BlocProvider<SintomaBloc>(
                          create: (BuildContext context) =>
                              di.sl<SintomaBloc>(),
                        ),
                      ],
                      child: CriseMain(),
                    ),
                  ),
                );
              },
              child: const Text('Crise'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
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
                          create: (BuildContext context) =>
                              di.sl<MedicamentoBloc>(),
                        ),
                        BlocProvider<GatilhoBloc>(
                          create: (BuildContext context) =>
                              di.sl<GatilhoBloc>(),
                        ),
                        BlocProvider<SintomaBloc>(
                          create: (BuildContext context) =>
                              di.sl<SintomaBloc>(),
                        ),
                      ],
                      child: CalendarioScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Calendario'),
            ),
          ],
        ),
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<CriseBloc, CriseState>(
        builder: (context, state) {
          if (state is CriseLoading) {
            return LoadingWidget();
          } else if (state is CriseLoaded) {
            return CalendarioScreen(crises: state.crises);
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

  void dispatchRandom() {
    print('dispatchRandom');
  }
}
