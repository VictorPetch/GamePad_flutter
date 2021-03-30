import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:radar_chart/radar_chart.dart';

// ignore: must_be_immutable
class Info extends StatefulWidget {
  String categoria;
  Info(this.categoria);
  @override
  _InfoState createState() => _InfoState();
}

List<String> iconList;
List<String> textList;
String infoText;

class _InfoState extends State<Info> {
  String categoria;
  @override
  void initState() {
    this.categoria = widget.categoria;
    iconList = ['desafiosButton.png', 'homeButton.png', 'conquistasButon.png'];
    textList = [
      'Desafios',
      'Home',
      'Conquistas',
    ];
    if (categoria == 'Tático') {
      infoText = 'Texto sobre tático';
    } else if (categoria == 'Técnico') {
      infoText = 'Texto sobre técnico';
    } else if (categoria == 'Físico') {
      infoText = 'Texto sobre físico';
    }else if (categoria == 'Outros') {
      infoText = 'Texto sobre outros';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;
    var safeAreaTop = MediaQuery.of(context).padding.top;
    var width = MediaQuery.of(context).size.width;
    var height =
        MediaQuery.of(context).size.height - safeAreaTop - safeAreaBottom;
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
                        categoria,
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

                  //Info
                  Container(
                    width: width * 0.8,
                    height: height * 0.55,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.03),
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/self_evaluation/info.png'),
                    )),
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color(0xffd4d4d4),
                          fontSize: 14),
                    ),
                  ),

                  Container(
                    // padding: EdgeInsets.only(right: width * 0.2),
                    width: width * 0.8,
                    height: height * 0.02,
                    // color: Colors.blue,
                  ),
                ],
              ),
            ),
            //Bottom
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
