import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ies_calculator/self_evaluation/info.dart';
import 'package:radar_chart/radar_chart.dart';

// ignore: must_be_immutable
class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

List<String> buttonList;
List<String> buttonTexts;
List<String> iconList;
List<String> textList;

class _ResultsState extends State<Results> {
  @override
  void initState() {
    //Get action values from last screen
    buttonList = [
      'rectangleButton.png',
      'rectangleButton.png',
      'rectangleButton.png',
      'rectangleButton.png'
    ];
    buttonTexts = ['Tático', 'Técnico', 'Físico', 'Outros'];
    iconList = ['desafiosButton.png', 'homeButton.png', 'conquistasButon.png'];
    textList = [
      'Desafios',
      'Home',
      'Conquistas',
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;
    var safeAreaTop = MediaQuery.of(context).padding.top;
    var width = MediaQuery.of(context).size.width;
    var height =
        MediaQuery.of(context).size.height - safeAreaTop - safeAreaBottom;
    final PageController controller = PageController(initialPage: 0);
    print('dev $width $height $safeAreaBottom $safeAreaTop');
    final ScrollController _scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/self_evaluation/bg.png'))),
        child: Column(
          children: [
            Container(
              width: width * 1,
              height: height * 0.15,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                      constraints: BoxConstraints(maxHeight: height * 0.10),
                      width: width * 0.1,
                      height: 40,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/self_evaluation/menuButton.png'))),
                    ),
                  ),
                  Container(
                    child: Center(
                        child: AutoSizeText(
                      'Auto Avaliação',
                      minFontSize: 20,
                      maxLines: 1,
                      style: TextStyle(
                          color: Color(0xff9a9a9a),
                          fontFamily: 'BebasNeue',
                          fontSize: 31,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
            ),
            //Body
            Container(
              width: width * 1,
              height: height * 0.72,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Resultado
                  Container(
                    width: width * 0.5,
                    height: height * 0.08,
                    // color: Colors.blue,
                    child: Center(
                      child: AutoSizeText(
                        'Resultado',
                        minFontSize: 20,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color(0xffc8d94d),
                            fontFamily: 'BebasNeue',
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  //Graph
                  Container(
                    width: width * 0.8,
                    height: height * 0.23,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/self_evaluation/graph.png'),
                    )),
                    child: Stack(
                      children: [
                        Center(
                          child: RadarChart(
                            length: 4,
                            initialAngle: 0,
                            radialColor: Colors.transparent,
                            radialStroke: 2,
                            backgroundColor: Colors.transparent,
                            radars: [
                              RadarTile(
                                values: [
                                  1, //Ofensivo
                                  0.7, //Passe
                                  0.4, //Vitalidade
                                  0.2, //Chute
                                ],
                                borderColor: Color(0xfff6615b),
                                backgroundColor: Colors.transparent,
                                borderStroke: 2,
                              ),
                              RadarTile(
                                values: [
                                  0,
                                  0.3,
                                  0.6,
                                  0.8,
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
                        Positioned(
                          left: width * 0.18,
                          top: height * 0.018,
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.03,
                            // color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Chute',
                                style: TextStyle(
                                    color: Color(0xffa1bb44),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: width * 0.03,
                          top: height * 0.096,
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.03,
                            // color: Colors.blue,
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Vitalidade',
                                style: TextStyle(
                                    color: Color(0xffa1bb44),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: width * 0.03,
                          top: height * 0.096,
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.03,
                            // color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Ofensivo',
                                style: TextStyle(
                                    color: Color(0xffa1bb44),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: width * 0.18,
                          bottom: height * 0.026,
                          child: Container(
                            width: width * 0.2,
                            height: height * 0.03,
                            // color: Colors.blue,
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Vitalidade',
                                style: TextStyle(
                                    color: Color(0xffa1bb44),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Buttons
                  Container(
                    // padding: EdgeInsets.only(right: width * 0.2),
                    width: width * 0.8,
                    height: height * 0.33,
                    // color: Colors.blue,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      controller: _scrollController,
                      child: Container(
                        padding: EdgeInsets.only(right: width * 0.1),
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    buttonList[index] =
                                        'rectangleButton_pressed.png';
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    buttonList[index] = 'rectangleButton.png';
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) => Info(
                                              buttonTexts[index]
                                            ))));
                                  });
                                },
                                onTapCancel: () {
                                  setState(() {
                                    buttonList[index] = 'rectangleButton.png';
                                  });
                                },
                                child: Container(
                                  height: height * 0.1,
                                  padding: EdgeInsets.only(
                                      bottom: height * 0.01,
                                      left: width * 0.05),
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.02),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/self_evaluation/${buttonList[index]}'),
                                  )),
                                  child: Text(
                                    buttonTexts[index],
                                    style: TextStyle(
                                        color: Color(0xff1c1c1c),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                
                ],
              ),
            ),
            
            Container(
              width: width,
              height: height * 0.13,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        if (index == 0) {
                          iconList[index] = 'desafiosButton_pressed.png';
                        } else if (index == 1) {
                          iconList[index] = 'homeButton_pressed.png';
                        } else
                          iconList[index] = 'conquistasButon_pressed.png';
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        if (index == 0) {
                          iconList[index] = 'desafiosButton.png';
                        } else if (index == 1) {
                          iconList[index] = 'homeButton.png';
                        } else
                          iconList[index] = 'conquistasButon.png';
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        if (index == 0) {
                          iconList[index] = 'desafiosButton.png';
                        } else if (index == 1) {
                          iconList[index] = 'homeButton.png';
                        } else
                          iconList[index] = 'conquistasButon.png';
                      });
                    },
                    child: Container(
                      width: width * 0.26,
                      height: height * 0.1,
                      // color: Colors.red,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/self_evaluation/${iconList[index]}',
                              scale: 0.5,
                            ),
                          ),
                          Container(
                            width: width,
                            height: height * 0.04,
                            // color: Colors.green,
                            child: Center(
                              child: AutoSizeText(
                                textList[index],
                                maxLines: 1,
                                minFontSize: 5,
                                style: TextStyle(
                                  color: Color(0xffb9cd58),
                                  fontFamily: 'Oswald',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
