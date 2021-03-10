import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ies_calculator/teste.dart';
import 'package:ies_calculator/resultModel.dart';
import 'package:ies_calculator/utils/utils.dart';
import 'package:ies_calculator/utils/widget_to_image.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:radar_chart/radar_chart.dart';

//This main is to be used when you want to test different screen sizes
// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MaterialApp(
//           home: ResultadoScreen(),
//           locale: DevicePreview.locale(context),
//           builder: DevicePreview.appBuilder,
//         ), // Wrap your app
//       ),
//     );

// void main() => runApp(ResultadoScreen());

double redCards = 0, yellowCards = 0;
var red = Colors.red;
double passeCerto,
    passeErrado,
    desarmeCerto,
    desarmeErrado,
    golCerto,
    golErrado,
    chuteCerto,
    chuteErrado,
    assisCerto,
    assisErrado,
    dribleCerto,
    dribleErrado;
double passePercentage;
TextEditingController golSeuTime, golTimeInimigo;

// ignore: must_be_immutable
class ResultadoScreen extends StatefulWidget {
  var results = new ResultsModel();
  ResultadoScreen(this.results);

  @override
  _ResultadoScreenState createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  GlobalKey key;
  Uint8List bytes;
  PreferredSizeWidget _vertex;
  bool isShared = false;
  Color red = Color(0xffff5a5a);
  Color green = Color(0xff47ff84);
  Color yellow = Color(0xfffff947);

  double getNumberOfActions(String action, Color color) {
    var actions = [];
    for (var i = 0; i < widget.results.actionTimeline.length; i++) {
      if (widget.results.actionTimeline[i] == action &&
          widget.results.colorTimeline[i].value == color.value) actions.add(i);
    }
    return actions.isEmpty ? 0 : actions.length.toDouble();
  }

  @override
  void initState() {
    //Get action values from last screen
    print(widget.results);
    passeErrado = getNumberOfActions('Passe', red);
    desarmeErrado = getNumberOfActions('Desarme', red);
    dribleErrado = getNumberOfActions('Drible', red);
    // golErrado = getNumberOfActions('Gol');
    chuteErrado = getNumberOfActions('Chute ao Gol', red);
    assisErrado = 0; //getNumberOfActions('Assistência');

    passeCerto = getNumberOfActions('Passe', green);
    desarmeCerto = getNumberOfActions('Desarme', green);
    dribleCerto = getNumberOfActions('Drible', green);
    chuteCerto = getNumberOfActions('Chute ao Gol', green);
    golCerto = getNumberOfActions('Gol', green);
    assisCerto = getNumberOfActions('Assistência', green);

    redCards = getNumberOfActions('Cartão Vermelho', red);
    yellowCards = getNumberOfActions('Cartão Amarelo', yellow);

    golSeuTime = new TextEditingController(text: '0');
    golTimeInimigo = new TextEditingController(text: '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.results);
    _vertex = PreferredSize(
      preferredSize: Size(20, 20),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 8,
      ),
    );

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;
    var safeAreaTop = MediaQuery.of(context).padding.top;

    print('dev $width $height $safeAreaBottom $safeAreaTop');

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: WidgetToImage(builder: (key) {
            return Stack(
              children: [
                // #region Background
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/resultados/cadastro_BG.png'),
                    ),
                  ),
                ),
                // #endregion

                Column(
                  children: [
                    // #region Review da partida
                    Container(
                      height: height * 0.1,
                      width: width * 0.8,
                      // color: Colors.red,
                      margin: EdgeInsets.only(bottom: 10, top: height * 0.025),
                      child: Center(
                        child: AutoSizeText(
                          'REVIEW DA PARTIDA',
                          minFontSize: 30,
                          style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 50,
                              color: Color(0xff9b9b9b)),
                        ),
                      ),
                    ),
                    // #endregion

                    // #region Placar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Meu time
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.11,
                              width: width * 0.22,
                              child: Center(
                                child: Container(),
                              ),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/resultados/cadastro_Placar.png'),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: width * 0.032),
                              width: width * 0.1,
                              height: height * 0.07,
                              // color: Colors.blue,
                              child: Center(
                                child: TextFormField(
                                  controller: golSeuTime,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontFamily: 'BebasNeue',
                                      fontSize: 33,
                                      color: Color(0xfff4fe90)),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // X
                        Container(
                          height: height * 0.03,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/resultados/cadastro_X.png'),
                            ),
                          ),
                        ),

                        //Time inimigo
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.11,
                              width: width * 0.22,
                              child: Center(
                                child: Container(),
                              ),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/resultados/cadastro_Placar.png'),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: width * 0.032),
                              width: width * 0.1,
                              height: height * 0.07,
                              // color: Colors.blue,
                              child: Center(
                                child: TextFormField(
                                  controller: golTimeInimigo,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontFamily: 'BebasNeue',
                                      fontSize: 33,
                                      color: Color(0xfff4fe90)),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // #endregion

                    // #region Seu time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.blue,
                          width: width * 0.22,
                          child: Center(
                            child: AutoSizeText(
                              'Seu time',
                              minFontSize: 14,
                              style: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 18,
                                  color: Color(0xffc0cc46)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.15,
                        ),
                        Container(
                          // color: Colors.blue,
                          width: width * 0.22,
                          child: Center(
                            child: AutoSizeText(
                              'Adversário',
                              minFontSize: 14,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'BebasNeue',
                                  fontSize: 18,
                                  color: Color(0xffc0cc46)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // #endregion

                    // #region Graph region
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: width * 0.9,
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/resultados/Graph.png'),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: RadarChart(
                                length: 6,
                                initialAngle: 0,
                                radialColor: Colors.transparent,
                                radialStroke: 2,
                                backgroundColor: Colors.transparent,
                                radars: [
                                  RadarTile(
                                    values: [
                                      dribleErrado > 0
                                          ? dribleErrado /
                                              (dribleErrado + dribleCerto)
                                          : 0.0,
                                      1,
                                      chuteErrado > 0
                                          ? chuteErrado / (chuteErrado + chuteCerto)
                                          : 0.0,
                                      1,
                                      desarmeErrado > 0
                                          ? desarmeErrado /
                                              (desarmeCerto + desarmeErrado)
                                          : 0.0,
                                      passeErrado > 0.0
                                          ? passeErrado / (passeErrado + passeCerto)
                                          : 0.0,
                                    ],
                                    borderColor: Color(0xfff6615b),
                                    backgroundColor: Colors.transparent,
                                    borderStroke: 2,
                                  ),
                                  RadarTile(
                                    values: [
                                      dribleCerto > 0
                                          ? dribleCerto /
                                              (dribleErrado + dribleCerto)
                                          : 0.0,
                                      golCerto,
                                      chuteCerto > 0
                                          ? chuteCerto / (chuteErrado + chuteCerto)
                                          : 0.0,
                                      assisCerto,
                                      desarmeCerto > 0
                                          ? desarmeCerto /
                                              (desarmeCerto + desarmeErrado)
                                          : 0.0,
                                      passeCerto > 0.0
                                          ? passeCerto / (passeErrado + passeCerto)
                                          : 0.0,
                                    ],
                                    borderColor: Color(0xff78ba68),
                                    backgroundColor: Colors.transparent,
                                    borderStroke: 2,
                                  ),
                                ],
                                radius: (width * 0.4) > height * 0.18
                                    ? height * 0.09
                                    : width * 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // #endregion

                    // #region List
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        // color: Colors.red,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ListTile(
                              width: width,
                              height: height,
                              action: 'Gol',
                              alliedPoints: golCerto.toInt(),
                              enemyPoints: 0,
                              // enemyPoints: golCerto.toInt() +
                              //     int.parse(golSeuTime.text)
                            ),
                            ListTile(
                                width: width,
                                height: height,
                                action: 'Assistência',
                                alliedPoints: assisCerto.toInt(),
                                // enemyPoints: assisErrado.toInt()
                                enemyPoints: 0),
                            ListTile(
                                width: width,
                                height: height,
                                action: 'Passe',
                                alliedPoints: passeCerto.toInt(),
                                enemyPoints: passeErrado.toInt()),
                            ListTile(
                                width: width,
                                height: height,
                                action: 'Chute ao Gol',
                                alliedPoints: chuteCerto.toInt(),
                                enemyPoints: chuteErrado.toInt()),
                            ListTile(
                                width: width,
                                height: height,
                                action: 'Desarme',
                                alliedPoints: desarmeCerto.toInt(),
                                enemyPoints: desarmeErrado.toInt()),
                            ListTile(
                                width: width,
                                height: height,
                                action: 'Drible',
                                alliedPoints: dribleCerto.toInt(),
                                enemyPoints: dribleErrado.toInt()),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 28),
                                  // color: Colors.blue,
                                  height: height * 0.02,
                                  width: width * 0.3,
                                  child: AutoSizeText(
                                    'Cartões',
                                    maxLines: 1,
                                    minFontSize: 6,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      color: Color(0xffc0cc46),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: height * 0.02,
                                  width: width * 0.1,
                                  decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/resultados/cadastro_cardRed.png'))),
                                  child: Center(
                                    child: AutoSizeText(
                                      redCards.toInt().toString(),
                                      maxLines: 1,
                                      minFontSize: 6,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: height * 0.02,
                                  width: width * 0.1,
                                  decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/resultados/cadastro_cardYellow.png'))),
                                  child: Center(
                                    child: AutoSizeText(
                                      redCards.toInt().toString(),
                                      maxLines: 1,
                                      minFontSize: 6,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // #endregion

                    // #region Final button
                    isShared
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    isShared = true;
                                  });
                                  final bytes = await Utils.capture(key);
                                  setState(() {
                                    this.bytes = bytes;
                                  });
                                  await Utils.createFileFromString(bytes);

                                  setState(() {
                                    isShared = false;
                                    this.bytes = null;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20, bottom: 20),
                                  height: height * 0.07,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                    // color: Colors.green,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/resultados/share_button.png'),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new PlayerCard()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20, bottom: 20),
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
            );
          }
        ),
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  const ListTile({
    Key key,
    @required this.width,
    @required this.height,
    @required this.action,
    @required this.alliedPoints,
    @required this.enemyPoints,
  }) : super(key: key);

  final double width;
  final double height;
  final String action;
  final int alliedPoints;
  final int enemyPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28),
      margin: EdgeInsets.only(bottom: height * 0.015),
      width: width,
      //  color: Colors.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.blue,
            height: height * 0.02,
            width: width * 0.3,
            child: AutoSizeText(
              action,
              maxLines: 1,
              minFontSize: 6,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                color: Color(0xffc0cc46),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // #region First Linear Gradient
                Container(
                  height: height * 0.02,
                  // color: Colors.red,
                  child: Center(
                    child: LinearPercentIndicator(
                      linearGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff59570),
                          Color(0xfff5615b),
                        ],
                      ),
                      lineHeight: height * 0.02,
                      percent: 1,
                      // progressColor: Color(0xff79ba68),
                      backgroundColor: Color(0x00f5615b),
                    ),
                  ),
                ),
                // #endregion

                // #region Second Linear Gradient
                Container(
                  height: height * 0.02,
                  // color: Colors.red,
                  child: Center(
                    child: LinearPercentIndicator(
                      animation: true,
                      linearGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff79ba68),
                          Color(0xff88c26e),
                        ],
                      ),
                      lineHeight: height * 0.02,
                      percent: alliedPoints > 0
                          ? alliedPoints / (alliedPoints + enemyPoints)
                          : 0,
                      // progressColor: Color(0xff79ba68),
                      backgroundColor: Color(0x00f5615b),
                    ),
                  ),
                ),
                // #endregion

                // #region Text
                Container(
                  height: height * 0.02,
                  // color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        alliedPoints.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        enemyPoints.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                // #endregion
              ],
            ),
          )
        ],
      ),
    );
  }
}
