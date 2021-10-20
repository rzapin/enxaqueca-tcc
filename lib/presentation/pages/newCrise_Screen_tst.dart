import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/presentation/bloc/crise/crise_bloc.dart';
import 'package:enxaqueca/presentation/bloc/medicamento/medicamento_bloc.dart';
import 'package:enxaqueca/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_picker/flutter_picker.dart';

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
      appBar: AppBar(title: Text("Inserir nova crise")),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Dia e hora de início:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _showDiaHoraInicioPicker(context);
                      },
                      onSaved: (_) {
                        _formData['diaHoraInicio'] = hrInicioPicker;
                      },
                    ),
                  ),
                  Text("Dia e hora de fim:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _showDiaHoraFimPicker(context);
                      },
                      onSaved: (_) {
                        _formData['diaHoraFim'] = hrFimPicker;
                      },
                    ),
                  ),
                  Text("Intensidade:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showMaterialNumberPicker(
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
                  Text("Medicamento:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _medPickerBlocBuilder(),
                  ),
                  Text("Gatilho:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['gatilho'] = val;
                      },
                    ),
                  ),
                  Text("Sintoma:"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      //initialValue: ,
                      onSaved: (val) {
                        _formData['sintoma'] = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Enviar"),
                      onPressed: () {
                        _sendToServer(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendToServer(BuildContext context) {
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


  _showDiaHoraInicioPicker(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMDHM,
          hourSuffix: "   :",
          minHour: 00,
          maxHour: 23,
          yearBegin: 2000,
        ),
        title: Text("Selecione a hora de inicio"),
        onConfirm: (Picker picker, List value) {
          hrInicioPicker = picker.adapter.text;
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          print(picker.adapter.toString());
        }
    ).show(_scaffoldKey.currentState);
  }

  _showDiaHoraFimPicker(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMDHM,
          hourSuffix: "   :",
          minHour: 00,
          maxHour: 23,
          yearBegin: 2000,
        ),
        title: Text("Selecione a hora de fim"),
        onConfirm: (Picker picker, List value) {
          hrFimPicker = picker.adapter.text;
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          print(picker.adapter.toString());
        }
    ).show(_scaffoldKey.currentState);
  }

  _medPickerBlocBuilder() {
    return BlocBuilder<MedicamentoBloc, MedicamentoState>(
        builder: (context, state) {
      if (state is MedicamentoLoading) {
        return LoadingWidget();
      } else if (state is MedicamentoLoaded) {
        Medicamento selectedMed = state.medicamentos.isEmpty ? null : state.medicamentos[0];
        return TextFormField(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            showMaterialRadioPicker<Medicamento>(
                title: "Selecione o medicamento",
                context: context,
                items: state.medicamentos,
                selectedItem: selectedMed,
                transformer: (item) {
                  return item.nome + ' ' + item.dosagem.toString() + 'mg';
                },
                onChanged: (val) {
                  setState(() {
                    selectedMed = val;
                  });
                },
                onConfirmed: () {
                  medicamentoPicker = selectedMed.id;
                });
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
    });
  }
}
