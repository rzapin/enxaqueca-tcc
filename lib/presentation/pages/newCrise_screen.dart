import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'newMedicamento_screen.dart';

class NewCriseScreen extends StatefulWidget {
  @override
  _NewCriseScreenState createState() => _NewCriseScreenState();
}

class _NewCriseScreenState extends State<NewCriseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Variaveis para carregar do picker para o textfield
  String hrInicioPicker = DateTime.now().toString(); //Como padrao a hora atual
  String hrFimPicker;
  String intensidadePicker = '5'; //Como padrao a intensidade mediana
  String medicamentoPicker;
  String gatilhoPicker;
  String sintomaPicker;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<MedicamentoBloc>(context).add(GetAllMedicamentosEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Nova crise")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 45.0, top: 60.0, right: 60.0, bottom: 60.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.access_time,
                            size: 100.0,
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _showDiaHoraInicioPicker(context);
                        },
                        onSaved: (_) {
                          _formData['diaHoraInicio'] = hrInicioPicker;
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.pink,
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.white70,
                          size: 70.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.access_time,
                            size: 100.0,
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _showDiaHoraFimPicker(context);
                        },
                        onSaved: (_) {
                          _formData['diaHoraFim'] = hrFimPicker;
                        },
                        validator: (String value) {
                          if (value != 'Ok') {
                            return "A data de fim não pode ser menor do que a data de início.";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 45.0, top: 60.0, right: 60.0, bottom: 60.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.error_outline,
                            size: 100.0,
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showMaterialNumberPicker(
                            title: "Qual a intensidade da dor?",
                            cancelText: "",
                            confirmText: "OK",
                            headerColor: Color(0xff212121),
                            headerTextColor: Colors.white,
                            backgroundColor: Color(0xff424242),
                            //Color(0xff212121),//Color(0xff616161),
                            context: context,
                            minNumber: 1,
                            maxNumber: 10,
                            onChanged: (val) {
                              intensidadePicker = val.toString();
                            },
                          );
                        },
                        onSaved: (_) {
                          _formData['intensidade'] = intensidadePicker;
                        },
                      ),
                    ),
                    Expanded(
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      child: _medPickerBlocBuilder(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 60.0, left: 60.0, bottom: 10.0, right: 60.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                    ),
                    Expanded(
                      child: ButtonTheme(
                        minWidth: 200.0,
                        height: 200.0,
                        child: ElevatedButton(
                          child: Text("Cadastrar"),
                          onPressed: () {
                            _sendToServer(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendToServer(BuildContext context) {
    if (DateTime.parse(hrFimPicker).isBefore(DateTime.parse(hrInicioPicker))) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                Text("A hora de fim não pode ser menor que a hora de início!"),
          );
        },
      );
    } else if (DateTime.parse(hrInicioPicker).isAfter(DateTime.now())) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("A hora de inicio deve ser anterior à hora atual!"),
          );
        },
      );
    } else {
      _formKey.currentState.save();

      final newCrise = Crise(
        diaHoraInicio: DateTime.parse((_formData['diaHoraInicio'])),
        diaHoraFim: DateTime.parse((_formData['diaHoraFim'])),
        intensidade: int.parse(_formData['intensidade']),
        medicamento: _formData['medicamento'],
        //gatilho: _formData['gatilho'],
        //sintoma: _formData['sintoma']
      );

      BlocProvider.of<CriseBloc>(context).add(NewCriseEvent(newCrise));

      Navigator.pop(context);
    }
  }

  _showDiaHoraInicioPicker(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMDHM,
          hourSuffix: "h",
          minuteSuffix: "m",
          minuteInterval: 5,
          yearBegin: 2000,
        ),
        confirmText: "OK",
        backgroundColor: Colors.white60,
        confirmTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        cancel: SizedBox.shrink(),
        title: Text(
          "Quando começou a crise?",
          style: TextStyle(color: Colors.white60),
        ),
        onConfirm: (Picker picker, List value) {
          hrInicioPicker = picker.adapter.text;
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          print(picker.adapter.toString());
        }).show(_scaffoldKey.currentState);
  }

  _showDiaHoraFimPicker(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMDHM,
          hourSuffix: "h",
          minuteSuffix: "m",
          minuteInterval: 5,
          yearBegin: 2000,
          initialTime:
              DateTime.parse(hrInicioPicker).add(const Duration(hours: 6)),
        ),
        confirmText: "OK",
        backgroundColor: Colors.white60,
        confirmTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        cancel: SizedBox.shrink(),
        title: Text(
          "Quando terminou a crise?",
          style: TextStyle(color: Colors.white60),
        ),
        onConfirm: (Picker picker, List value) {
          hrFimPicker = picker.adapter.text;
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          print(picker.adapter.toString());
        }).show(_scaffoldKey.currentState);
  }

  _medPickerBlocBuilder() {
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
      builder: (context, state) {
        if (state is MedicamentoLoading) {
          return LoadingWidget();
        } else if (state is MedicamentoLoaded) {
          Medicamento selectedMed =
              state.medicamentos.isEmpty ? null : state.medicamentos[0];
          return TextFormField(
            decoration: const InputDecoration(
              icon: Icon(
                Icons.medication,
                size: 100.0,
                color: Colors.white70,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              showMaterialRadioPicker<Medicamento>(
                title: "Tomou medicamento?",
                context: context,
                items: state.medicamentos,
                selectedItem: selectedMed,
                cancelText: "Não tomei",
                onCancelled: () => medicamentoPicker = null,
                transformer: (item) {
                  return item.nome + ' ' + item.dosagem.toString() + 'mg';
                },
                onChanged: (val) {
                  setState(
                    () {
                      selectedMed = val;
                    },
                  );
                },
                onConfirmed: () =>
                    medicamentoPicker = "/medicamentos/" + selectedMed.id,
              );
            },
            onSaved: (val) {
              _formData['medicamento'] = medicamentoPicker;
            },
          );
        } else
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
