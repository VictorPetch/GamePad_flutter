import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ies_calculator/resultModel.dart';
import 'package:expandable/expandable.dart';
import 'package:ies_calculator/resultado_screen.dart';
import 'package:intl/intl.dart';

// This main is to be used when you want to test different screen sizes
ResultsModel results = new ResultsModel();
// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MaterialApp(
//           home: CadastroScreen(results),
//           locale: DevicePreview.locale(context),
//           builder: DevicePreview.appBuilder,
//         ), // Wrap your app
//       ),
//     );

// void main() => runApp(CadastroScreen());

var nomeCampeonato = TextEditingController(text: '');
var posicao = TextEditingController(text: '');
var modalidade = TextEditingController(text: '');
var nomeTime = TextEditingController(text: '');
var timeAdversario = TextEditingController(text: '');
var local = TextEditingController(text: '');
var data = TextEditingController(text: '');
var red = Colors.red;
String notification = '';
int posicaoGroupValue;
var expandedPosition = ExpandableController();
var expandedModalidade = ExpandableController();
String dropDownText = '';

// ignore: must_be_immutable
class CadastroScreen extends StatefulWidget {
  ResultsModel results = new ResultsModel();
  CadastroScreen(this.results);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  DateTime selectedDate = DateTime.now();
  String date;
  Future<String> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return picked.toString().split(' ')[0];
    } else if (picked == selectedDate) {
      return selectedDate.toString().split(' ')[0];
    }
  }

  // #region initState
  @override
  void initState() {
    print('timestamp ${widget.results.timestamp}');
    print('actions ${widget.results.actionTimeline}');
    print('colors ${widget.results.colorTimeline}');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //Get action values from last screen
    super.initState();
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;
    var safeAreaTop = MediaQuery.of(context).padding.top;

    // print('dev $width $height $safeAreaBottom $safeAreaTop');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // #region Background
              Container(
                width: width,
                height: height - MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/cadastro/cadastro_BG.png'),
                  ),
                ),
              ),
              // #endregion

              Column(
                children: [
                  // #region Cadastro de partida
                  Container(
                    height: height * 0.1,
                    width: width * 0.8,
                    // color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10, top: height * 0.025),
                    child: Center(
                      child: AutoSizeText(
                        'CADASTRO DE PARTIDA',
                        minFontSize: 30,
                        style: TextStyle(
                            fontFamily: 'BebasNeue',
                            fontSize: 50,
                            color: Color(0xff9b9b9b)),
                      ),
                    ),
                  ),
                  // #endregion

                  Container(
                    margin: EdgeInsets.only(
                        top: height * 0.04, bottom: height * 0.03),
                    width: width * 0.65,
                    height: height * 0.6,
                    padding: EdgeInsets.only(top: height * 0.02),
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // #region Nome do campeonato
                          mainButton(
                            width,
                            height,
                            'green',
                            nomeCampeonato,
                            height * 0.013,
                            'Nome do campeonato',
                          ),
                          // #endregion
                          
                          //Posição
                          ExpandableNotifier(
                            controller: expandedPosition,
                            child: ExpandablePanel(
                              // #region Collapsed
                              collapsed: Container(
                                margin: EdgeInsets.only(bottom: height * 0.013),
                                width: width,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/cadastro/cadastro_dropdown.png'),
                                  ),
                                ),
                                padding: EdgeInsets.only(right: width * 0.01),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: width * 0.05),
                                        alignment: Alignment.centerLeft,
                                        height: height * 0.1,
                                        // color: red,
                                        child: AutoSizeText(
                                          posicao.text.isEmpty
                                              ? 'Posição'
                                              : posicao.text,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    ExpandableButton(
                                      child: Container(
                                        width: width * 0.13,
                                        height: height * 0.08,
                                        //  color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // #endregion

                              // #region Expanded
                              expanded: Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.013),
                                  width: width,
                                  height: height * 0.36,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/cadastro/Componente3.png'),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                      right: width * 0.01,
                                      bottom: height * 0.01),
                                  child: Container(
                                    width: width * 0.55,
                                    // color: red,
                                    margin: EdgeInsets.only(top: height * 0.09),
                                    child: SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          posicaoTile(
                                            width: width,
                                            text: "Goleiro",
                                            englishText: 'Goalkeeper',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Zagueiro",
                                            englishText: 'CentreBack',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Lateral",
                                            englishText: 'WingBack',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Volante",
                                            englishText: 'DefensiveMidfielder',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Meia Extremo(Ponta)",
                                            englishText: 'SideMidfielder',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Meia Articulador",
                                            englishText: 'CentreMidfielder',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Atacante",
                                            englishText: 'Striker',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Universal",
                                            englishText: 'Universal',
                                            expanded: expandedPosition,
                                            controller: posicao
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              // #endregion
                            ),
                          ),
                         
                          //Modalidade
                          ExpandableNotifier(
                            controller: expandedModalidade,
                            child: ExpandablePanel(
                              // #region Collapsed
                              collapsed: Container(
                                margin: EdgeInsets.only(bottom: height * 0.013),
                                width: width,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/cadastro/cadastro_dropdown.png'),
                                  ),
                                ),
                                padding: EdgeInsets.only(right: width * 0.01),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: width * 0.05),
                                        alignment: Alignment.centerLeft,
                                        height: height * 0.1,
                                        // color: red,
                                        child: AutoSizeText(
                                          posicao.text.isEmpty
                                              ? 'Modalidade'
                                              : modalidade.text,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    ExpandableButton(
                                      child: Container(
                                        width: width * 0.13,
                                        height: height * 0.08,
                                        //  color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // #endregion

                              // #region Expanded
                              expanded: Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.013),
                                  width: width,
                                  height: height * 0.36,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/cadastro/Componente3.png'),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                      right: width * 0.01,
                                      bottom: height * 0.01),
                                  child: Container(
                                    width: width * 0.55,
                                    // color: red,
                                    margin: EdgeInsets.only(top: height * 0.09),
                                    child: SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          posicaoTile(
                                            width: width,
                                            text: "Futebol de Campo",
                                            englishText: 'Football',
                                            expanded: expandedModalidade,
                                            controller: modalidade
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Futsal",
                                            englishText: 'Futsal',
                                            expanded: expandedModalidade,
                                            controller: modalidade
                                          ),
                                          posicaoTile(
                                            width: width,
                                            text: "Futebol Society",
                                            englishText: 'Society Football',
                                            expanded: expandedModalidade,
                                            controller: modalidade
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              // #endregion
                            ),
                          ),

                          // #region Nome do time
                          mainButton(width, height, 'gray', nomeTime,
                              height * 0.013, 'Nome do time (opcional)'),
                          // #endregion

                          // #region Time adversário
                          mainButton(width, height, 'gray', timeAdversario,
                              height * 0.013, 'Time adversário (opcional)'),
                          // #endregion

                          // #region Local
                          mainButton(width, height, 'gray', local,
                              height * 0.013, 'Local do jogo (opcional)'),
                          // #endregion,

                          // #region Data

                          Stack(
                            children: [
                              mainButton(width, height, 'green', data, 0,
                                  date ?? 'Data do jogo',enabled: false),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () async {
                                    String thisDate =
                                        await _selectDate(context);
                                    setState(() {
                                      date = thisDate;
                                    });
                                    print('selected date: $date');
                                  },
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(top: 15, right: 25),
                                      width: 30,
                                      height: 30,
                                      child: Icon(Icons.calendar_today)),
                                ),
                              ),
                            ],
                          ),

                          // #endregion
                        ],
                      ),
                    ),
                  ),

                  // #region Final button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.5,
                        height: height * 0.05,
                        // color: red,
                        margin: EdgeInsets.only(right: width * 0.1, bottom: 0),
                        child: AutoSizeText(
                          notification != '' ? notification : '',
                          maxLines: 2,
                          style: TextStyle(fontSize: 14, color: red),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //TODO levar pra results page
                          setState(() {
                            notification = '';
                          });
                          print('posicao ${posicao.text}');

                          if (nomeCampeonato.text.isEmpty ||
                              posicao.text.isEmpty ||
                              date.isEmpty) {
                            setState(() {
                              notification =
                                  "Por favor, preencha os campos verdes.";
                            });
                          } else {
                            //Ir pra outra pagina
                            widget.results.nomeCampeonato = nomeCampeonato.text;
                            widget.results.posicao = posicao.text;
                            widget.results.modalidade = modalidade.text;
                            widget.results.nomeTime = nomeTime.text;
                            widget.results.timeAdversario = timeAdversario.text;
                            widget.results.local = local.text;
                            widget.results.data = date;
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new ResultadoScreen(widget.results)));
                          }
                          print('Dentro do modelo tem os seguintes campos:');
                          print(widget.results.nomeCampeonato);
                          print(widget.results.posicao);
                          print(widget.results.modalidade);
                          print(widget.results.nomeTime);
                          print(widget.results.timeAdversario);
                          print(widget.results.local);
                          print(widget.results.data);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50),
                          height: height * 0.07,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            // color: Colors.green,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/resultados/cadastro_check.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // #endregion
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // #region posicaoTile
  Container posicaoTile(
      {double width,
      String text,
      String englishText,
      TextEditingController controller,
      ExpandableController expanded}) {
    return Container(
      width: width * 0.55,
      margin: EdgeInsets.only(left: width * 0.05, bottom: 10),
      // color: red,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded.toggle();
            controller.text = text;
          });
        },
        child: AutoSizeText(
          '$text',
          // '$englishText: \"$text\"',
          maxLines: 2,
          minFontSize: 10,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
  // #endregion

  // #region mainButton
  Container mainButton(
    double width,
    double height,
    String color,
    TextEditingController controller,
    double bottomPadding,
    String hintText,
    {bool enabled = true}
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: width * 0.7,
      height: height * 0.08,
      decoration: BoxDecoration(
        //  color: Colors.red,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/cadastro/cadastro_${color}Button.png'),
        ),
      ),
      child: Center(
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          onChanged: (text) {
            print(text);
            setState(() {
              print(controller.text);
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            // hintText: hintText,
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.black)
          ),
        ),
      ),
    );
  }
  // #endregion
}
