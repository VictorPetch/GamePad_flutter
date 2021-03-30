import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ies_calculator/self_evaluation/results.dart';

void main() => runApp(MaterialApp(home: SelfEvaluation()));
List<String> buttonListImages;
List<String> leftButton;
List<String> rightButton;
List<String> iconList;
List<String> textList;

// ignore: must_be_immutable
class SelfEvaluation extends StatefulWidget {
  @override
  _SelfEvaluationState createState() => _SelfEvaluationState();
}

class _SelfEvaluationState extends State<SelfEvaluation> {
  @override
  void initState() {
    //Get action values from last screen
    buttonListImages = [
      'squareButton_gray.png',
      'squareButton_gray.png',
      'squareButton_gray.png',
      'squareButton_gray.png'
    ];
    leftButton = [
      'nextButton_gray.png',
      'nextButton_green_mirror.png',
      'nextButton_green_mirror.png',
      'nextButton_green_mirror.png'
    ];
    rightButton = [
      'nextButton_green.png',
      'nextButton_green.png',
      'nextButton_green.png',
      'nextButton_gray_mirror.png'
    ];
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

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/self_evaluation/bg.png'))),
          child: Column(
            children: [
              //Header
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
                child: PageView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _page1(width, height, controller, 'Passe', buttonListImages,
                        leftButton, rightButton, 0),
                    _page2(width, height, controller, 'Chute', buttonListImages,
                        leftButton, rightButton, 1),
                    _page3(width, height, controller, 'Vitalidade',
                        buttonListImages, leftButton, rightButton, 2),
                    _page4(width, height, controller, 'Ofensivo',
                        buttonListImages, leftButton, rightButton, 3),

                    // _page2(width, height, controller),
                    // _page3(width, height, controller),
                    // _page4(width, height, controller),
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
                      onTapUp: (_){
                        setState(() {
                          if (index == 0) {
                            iconList[index] = 'desafiosButton.png';
                          } else if (index == 1) {
                            iconList[index] = 'homeButton.png';
                          } else
                            iconList[index] = 'conquistasButon.png';
                        });
                      },
                      onTapCancel: (){
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
        ),
      ),
    );
  }

  Widget _page1(
      double width,
      double height,
      PageController controller,
      String title,
      List<String> buttonListImages,
      List<String> leftButton,
      List<String> rightButton,
      int page) {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.1,
            // color: Colors.blue,
            child: Center(
              child: AutoSizeText(
                title,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/self_evaluation/nextButton_gray.png',
                width: width * 0.1,
                height: height * 0.07,
              ),
              Container(
                width: width * 0.8,
                height: height * 0.45,
                // color: Colors.green,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: ((width * 0.8) / (height * 0.45)),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: List.generate(4, (index) {
                    var options = [
                      'Bom',
                      'Muito bom',
                      'Mais ou menos',
                      'Ruim',
                    ];

                    return GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          buttonListImages[index] = 'squareButton_pressed.png';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          for (var i = 0; i < buttonListImages.length; i++) {
                            if (i == index) {
                              buttonListImages[i] = 'squareButton_selected.png';
                            } else
                              buttonListImages[i] = 'squareButton_gray.png';
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width * 0.03,
                            height * 0.03, height * 0.03, width * 0.03),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/self_evaluation/${buttonListImages[index]}'),
                        )),
                        child: AutoSizeText(
                          options[index],
                          minFontSize: 4,
                          style: TextStyle(
                              color: Color(0xff1c1c1c),
                              fontFamily: 'Oswald',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                onTapDown: (_) {
                  setState(() {
                    rightButton[page] = 'nextButton_greenPressed.png';
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    rightButton[page] = 'nextButton_green.png';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    rightButton[page] = 'nextButton_green.png';
                  });
                },
                child: Image.asset(
                  'assets/self_evaluation/${rightButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
            ],
          ),
          Container(
            width: width * 0.4,
            height: height * 0.05,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/self_evaluation/circleGreen.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _page2(
      double width,
      double height,
      PageController controller,
      String title,
      List<String> buttonListImages,
      List<String> leftButton,
      List<String> rightButton,
      int page) {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.1,
            // color: Colors.blue,
            child: Center(
              child: AutoSizeText(
                title,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                onTapDown: (_) {
                  setState(() {
                    leftButton[page] = 'nextButton_greenPressed_mirror.png';
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    leftButton[page] = 'nextButton_green_mirror.png';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    leftButton[page] = 'nextButton_green_mirror.png';
                  });
                },
                child: Image.asset(
                  'assets/self_evaluation/${leftButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
              Container(
                width: width * 0.8,
                height: height * 0.45,
                // color: Colors.green,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: ((width * 0.8) / (height * 0.45)),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: List.generate(4, (index) {
                    var options = [
                      'Bom',
                      'Muito bom',
                      'Mais ou menos',
                      'Ruim',
                    ];

                    return GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          buttonListImages[index] = 'squareButton_pressed.png';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          for (var i = 0; i < buttonListImages.length; i++) {
                            if (i == index) {
                              buttonListImages[i] = 'squareButton_selected.png';
                            } else
                              buttonListImages[i] = 'squareButton_gray.png';
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width * 0.03,
                            height * 0.03, height * 0.03, width * 0.03),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/self_evaluation/${buttonListImages[index]}'),
                        )),
                        child: AutoSizeText(
                          options[index],
                          minFontSize: 4,
                          style: TextStyle(
                              color: Color(0xff1c1c1c),
                              fontFamily: 'Oswald',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                onTapDown: (_) {
                  setState(() {
                    rightButton[page] = 'nextButton_greenPressed.png';
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    rightButton[page] = 'nextButton_green.png';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    rightButton[page] = 'nextButton_green.png';
                  });
                },
                child: Image.asset(
                  'assets/self_evaluation/${rightButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
            ],
          ),
          Container(
            width: width * 0.4,
            height: height * 0.05,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGreen.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _page3(
      double width,
      double height,
      PageController controller,
      String title,
      List<String> buttonListImages,
      List<String> leftButton,
      List<String> rightButton,
      int page) {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.1,
            // color: Colors.blue,
            child: Center(
              child: AutoSizeText(
                title,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                onTapDown: (_) {
                  setState(() {
                    leftButton[page] = 'nextButton_greenPressed_mirror.png';
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    leftButton[page] = 'nextButton_green_mirror.png';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    leftButton[page] = 'nextButton_green_mirror.png';
                  });
                },
                child: Image.asset(
                  'assets/self_evaluation/${leftButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
              Container(
                width: width * 0.8,
                height: height * 0.45,
                // color: Colors.green,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: ((width * 0.8) / (height * 0.45)),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: List.generate(4, (index) {
                    var options = [
                      'Bom',
                      'Muito bom',
                      'Mais ou menos',
                      'Ruim',
                    ];

                    return GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          buttonListImages[index] = 'squareButton_pressed.png';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          for (var i = 0; i < buttonListImages.length; i++) {
                            if (i == index) {
                              buttonListImages[i] = 'squareButton_selected.png';
                            } else
                              buttonListImages[i] = 'squareButton_gray.png';
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width * 0.03,
                            height * 0.03, height * 0.03, width * 0.03),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/self_evaluation/${buttonListImages[index]}'),
                        )),
                        child: AutoSizeText(
                          options[index],
                          minFontSize: 4,
                          style: TextStyle(
                              color: Color(0xff1c1c1c),
                              fontFamily: 'Oswald',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                onTapDown: (_) {
                  setState(() {
                    rightButton[page] = 'nextButton_greenPressed.png';
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    rightButton[page] = 'nextButton_green.png';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    rightButton[page] = 'nextButton_green.png';
                  });
                },
                child: Image.asset(
                  'assets/self_evaluation/${rightButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
            ],
          ),
          Container(
            width: width * 0.4,
            height: height * 0.05,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGreen.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _page4(
      double width,
      double height,
      PageController controller,
      String title,
      List<String> buttonListImages,
      List<String> leftButton,
      List<String> rightButton,
      int page) {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.1,
            // color: Colors.blue,
            child: Center(
              child: AutoSizeText(
                title,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                onTapDown: (_) {
                  setState(() {
                    leftButton[page] = 'nextButton_greenPressed_mirror.png';
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    leftButton[page] = 'nextButton_green_mirror.png';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    leftButton[page] = 'nextButton_green_mirror.png';
                  });
                },
                child: Image.asset(
                  'assets/self_evaluation/${leftButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
              Container(
                width: width * 0.8,
                height: height * 0.45,
                // color: Colors.green,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: ((width * 0.8) / (height * 0.45)),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: List.generate(4, (index) {
                    var options = [
                      'Bom',
                      'Muito bom',
                      'Mais ou menos',
                      'Ruim',
                    ];

                    return GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          buttonListImages[index] = 'squareButton_pressed.png';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          for (var i = 0; i < buttonListImages.length; i++) {
                            if (i == index) {
                              buttonListImages[i] = 'squareButton_selected.png';
                            } else
                              buttonListImages[i] = 'squareButton_gray.png';
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width * 0.03,
                            height * 0.03, height * 0.03, width * 0.03),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/self_evaluation/${buttonListImages[index]}'),
                        )),
                        child: AutoSizeText(
                          options[index],
                          minFontSize: 4,
                          style: TextStyle(
                              color: Color(0xff1c1c1c),
                              fontFamily: 'Oswald',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Go to results
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: ((context) => Results())));
                },
                child: Image.asset(
                  'assets/self_evaluation/${rightButton[page]}',
                  width: width * 0.1,
                  height: height * 0.07,
                ),
              ),
            ],
          ),
          Container(
            width: width * 0.4,
            height: height * 0.05,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGray.png'),
                Image.asset('assets/self_evaluation/circleGreen.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
