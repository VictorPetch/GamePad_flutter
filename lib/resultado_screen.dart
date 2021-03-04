import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:percent_indicator/percent_indicator.dart';

//This main is to be used when you want to test different screen sizes
void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MaterialApp(
          home: ResultadoScreen(),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        ), // Wrap your app
      ),
    );

// void main() => runApp(ResultadoScreen());

var actionsList = [
  'Gol',
  'Assistência',
  'Passe',
  'Chute ao Gol',
  'Desarme',
  'Drible',
  'Cartões'
];
var alliedActionValues = [0, 0, 0, 0, 0, 0];
var enemyActionValues = [0, 0, 0, 0, 0, 0];

int redCards = 0, yellowCards = 0;

class ResultadoScreen extends StatefulWidget {
  @override
  _ResultadoScreenState createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  @override
  void initState() {
    //Get action values from last screen
    // var arguments = ModalRoute.of(context).settings.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;
    var safeAreaTop = MediaQuery.of(context).padding.top;

    print('dev $width $height $safeAreaBottom $safeAreaTop');

    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                    Container(
                      height: height * 0.11,
                      width: width * 0.22,
                      child: Center(
                        child: AutoSizeText(
                          '1',
                          minFontSize: 30,
                          style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 33,
                              color: Color(0xfff4fe90)),
                        ),
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
                    Container(
                      height: height * 0.11,
                      width: width * 0.22,
                      child: Center(
                        child: AutoSizeText(
                          '0',
                          minFontSize: 30,
                          style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 33,
                              color: Color(0xfff4fe90)),
                        ),
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

                // #region Radar Chart
                Center(
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.25,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage('assets/resultados/cadastro_graphB.png'),
                      ),
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
                            alliedPoints: 1,
                            enemyPoints: 3),
                        ListTile(
                            width: width,
                            height: height,
                            action: 'Assistência',
                            alliedPoints: 1,
                            enemyPoints: 3),
                        ListTile(
                            width: width,
                            height: height,
                            action: 'Passe',
                            alliedPoints: 1,
                            enemyPoints: 3),
                        ListTile(
                            width: width,
                            height: height,
                            action: 'Chute ao Gol',
                            alliedPoints: 1,
                            enemyPoints: 3),
                        ListTile(
                            width: width,
                            height: height,
                            action: 'Desarme',
                            alliedPoints: 1,
                            enemyPoints: 3),
                        ListTile(
                            width: width,
                            height: height,
                            action: 'Drible',
                            alliedPoints: 1,
                            enemyPoints: 3),
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
                                  redCards.toString(),
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
                                  redCards.toString(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
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

                //First Linear Gradient
                Container(
                  height: height * 0.02,
                  // color: Colors.red,
                  child: Center(
                    child: LinearPercentIndicator(
                      linearGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff5615b),
                          Color(0xffbd4a46),
                        ],
                      ),
                      animation: true,
                      lineHeight: height * 0.02,
                      percent: 1,
                      // progressColor: Color(0xff79ba68),
                      backgroundColor: Color(0x00f5615b),
                    ),
                  ),
                ),
                
                //Second Linear Gradient
                Container(
                  height: height * 0.02,
                  // color: Colors.red,
                  child: Center(
                    child: LinearPercentIndicator(
                      linearGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff79ba68),
                          Color(0xff548548),
                        ],
                      ),
                      lineHeight: height * 0.02,
                      percent: alliedPoints / (alliedPoints + enemyPoints),
                      // progressColor: Color(0xff79ba68),
                      backgroundColor: Color(0x00f5615b),
                    ),
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
