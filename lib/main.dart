import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:ies_calculator/cadastro_screen.dart';
import 'package:ies_calculator/resultModel.dart';
import 'package:ies_calculator/resultado_screen.dart';

void main() {
  runApp(MyApp());
}

String imageRedA = 'assets/calculadora/Button_Red.png';
String imageRedB = 'assets/calculadora/Button_Red.png';
String imageRedC = 'assets/calculadora/Button_Red.png';
String imageRedD = 'assets/calculadora/Button_Red.png';
String imageGreenA = 'assets/calculadora/Button_Green.png';
String imageGreenB = 'assets/calculadora/Button_Green.png';
String imageGreenC = 'assets/calculadora/Button_Green.png';
String imageGreenD = 'assets/calculadora/Button_Green.png';
String imageRedCard = 'assets/calculadora/redCard_Normal.png';
String imageYellowCard = 'assets/calculadora/yellowCard_Normal.png';
String imageEspecial1 = 'assets/calculadora/Button_Special.png';
String imageEspecial2 = 'assets/calculadora/Button_Special.png';
String imageUndo = 'assets/calculadora/undoButton.png';
String imageQuit = 'assets/calculadora/quitButton.png';
String imageStopWatch = 'assets/calculadora/quitButton.png';
String imageBlack = 'assets/calculadora/Button_Black.png';

List<String> timeline = [];
List<Color> timelineReview = [];
List<String> timestamps = [];
Color red = Color(0xffff5a5a);
Color green = Color(0xff47ff84);
Color yellow = Color(0xfffff947);
const double buttonSize = 50;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/*
  Note: As posições dos componentes seguem a equação scaleCoordinates.
  Basicamente, ele alinha os widgets baseado na relação entre a resolução 
  do dispositivo onde a tela foi feita e o dispositivo que ta rodando o
  app atualmente. A resolução do simulador é de (360,592). Por conta da 
  tela estar em landscape, a width está no lugar do height na função. Mas
  não tem problema, contanto que essa ordem seja mantida. Então os campos
  top e height devem receber 360 como original Height. 
*/

ResultsModel result;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int tick, savedTick;
  String minutesStr, secondsStr;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  bool isCounting = false;
  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  double scaleCoordinates(originalx, originalwidth, currentwidth) {
    return (originalx * currentwidth / originalwidth);
  }

  @override
  void initState() {
    result = new ResultsModel();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    tick = 0;
    savedTick = 0;
    minutesStr = '00';
    secondsStr = '00';
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          scrollable: true,
          title: new Text("Instruções"),
          content: Container(
            //color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // #region Cards
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/yellowCard_Normal.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Cartão Vermelho"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/redCard_Normal.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Cartão Amarelo"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                // #endregion

                // #region Extra buttons
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/assistenciaIcon3.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Assistência"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/golIcon1.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Gol"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                // #endregion

                // #region Others
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/Button_Green.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Ações completadas com sucesso"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/Button_Red.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Ações completadas sem sucesso"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/4-dribleIcon2.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Drible"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/1-finalizaçãoIcon1.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Chute"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/2-PasseIcon2.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Passe"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/3-desarmeIcon1.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Desarme"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/undoButton.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Começa e pausa o cronômetro"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/calculadora/undoButton.png',
                      height: 25,
                      width: 25,
                    ),
                    new Text("Reseta cronômetro"),
                  ],
                ),

                // #endregion
              ],
            ),
          ),
          actions: <Widget>[
            // define os botões na base do dialogo
            //TODO FlatButton Será depreciado no Flutter 2
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double Width = MediaQuery.of(context).size.width;
    final double Height = MediaQuery.of(context).size.height;

    //Dev
    //print('Width $Width | Height $Height');
    //bool hideContainers = true;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: Width,
                height: Height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      //'assets/calculadora/Mockup_Referencia_rotated.jpg',
                      'assets/calculadora/BG.png',
                    ),
                  ),
                ),
              ),
              //Red A
              Positioned(
                top: scaleCoordinates(185, 360, Height),
                left: scaleCoordinates(50, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                width: scaleCoordinates(buttonSize, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageRedA = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageRedA = 'assets/calculadora/pressedButton_Red.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Chute ao Gol');
                        timelineReview.insert(0, red);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageRedA = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageRedA),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/1-finalizaçãoIcon1.png'),
                    ),
                  ),
                ),
              ),
              //Red B
              Positioned(
                top: scaleCoordinates(185, 360, Height),
                left: scaleCoordinates(145, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                width: scaleCoordinates(buttonSize, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageRedB = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageRedB = 'assets/calculadora/pressedButton_Red.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Desarme');
                        timelineReview.insert(0, red);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageRedB = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageRedB),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/3-desarmeIcon1.png'),
                    ),
                  ),
                ),
              ),
              //Red C
              Positioned(
                top: scaleCoordinates(125, 360, Height),
                left: scaleCoordinates(97.5, 592, Width),
                width: scaleCoordinates(buttonSize, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageRedC = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageRedC = 'assets/calculadora/pressedButton_Red.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Drible');
                        timelineReview.insert(0, red);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageRedC = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageRedC),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/4-dribleIcon2.png'),
                    ),
                  ),
                ),
              ),
              //Red D
              Positioned(
                top: scaleCoordinates(240, 360, Height),
                left: scaleCoordinates(97.5, 592, Width),
                width: scaleCoordinates(buttonSize, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageRedD = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageRedD = 'assets/calculadora/pressedButton_Red.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Passe');
                        timelineReview.insert(0, red);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageRedD = 'assets/calculadora/Button_Red.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageRedD),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/2-PasseIcon2.png'),
                    ),
                  ),
                ),
              ),
              //Green A
              Positioned(
                top: scaleCoordinates(185, 360, Height),
                left: scaleCoordinates(50 + 345, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                width: scaleCoordinates(buttonSize, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageGreenA = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageGreenA = 'assets/calculadora/pressedButton_Green.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Chute ao Gol');
                        timelineReview.insert(0, green);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageGreenA = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageGreenA),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/1-finalizaçãoIcon1.png'),
                    ),
                  ),
                ),
              ),
              //Green B
              Positioned(
                top: scaleCoordinates(185, 360, Height),
                left: scaleCoordinates(145 + 345, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                width: scaleCoordinates(buttonSize, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageGreenB = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageGreenB = 'assets/calculadora/pressedButton_Green.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Desarme');
                        timelineReview.insert(0, green);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageGreenB = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageGreenB),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/3-desarmeIcon1.png'),
                    ),
                  ),
                ),
              ),
              //Green C
              Positioned(
                top: scaleCoordinates(125, 360, Height),
                left: scaleCoordinates(97.5 + 345, 592, Width),
                width: scaleCoordinates(buttonSize, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageGreenC = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageGreenC = 'assets/calculadora/pressedButton_Green.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Drible');
                        timelineReview.insert(0, green);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageGreenC = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageGreenC),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/4-dribleIcon2.png'),
                    ),
                  ),
                ),
              ),
              //Green D
              Positioned(
                top: scaleCoordinates(240, 360, Height),
                left: scaleCoordinates(97.5 + 345, 592, Width),
                width: scaleCoordinates(buttonSize, 592, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageGreenD = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageGreenD = 'assets/calculadora/pressedButton_Green.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Passe');
                        timelineReview.insert(0, green);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageGreenD = 'assets/calculadora/Button_Green.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageGreenD),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/2-PasseIcon2.png'),
                    ),
                  ),
                ),
              ),
              //Left Red Card
              Positioned(
                top: scaleCoordinates(39, 360, Height),
                left: scaleCoordinates(135, 592, Width),
                height: scaleCoordinates(buttonSize - 10, 360, Height),
                width: scaleCoordinates(buttonSize - 10, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageRedCard = 'assets/calculadora/redCard_Normal.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageRedCard = 'assets/calculadora/redCard_Pressed.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Cartão Vermelho');
                        timelineReview.insert(0, red);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageRedCard = 'assets/calculadora/redCard_Normal.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageRedCard),
                      ),
                      //color: Colors.white
                    ),
                  ),
                ),
              ),
              //Left Yellow Card
              Positioned(
                top: scaleCoordinates(39, 360, Height),
                left: scaleCoordinates(170, 592, Width),
                height: scaleCoordinates(buttonSize - 10, 360, Height),
                width: scaleCoordinates(buttonSize - 10, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageYellowCard = 'assets/calculadora/yellowCard_Normal.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageYellowCard = 'assets/calculadora/yellowCard_Pressed.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Cartão Amarelo');
                        timelineReview.insert(0, yellow);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageYellowCard = 'assets/calculadora/yellowCard_Normal.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageYellowCard),
                      ),
                      //color: Colors.white
                    ),
                  ),
                ),
              ),
              //Especial Button 1
              Positioned(
                top: scaleCoordinates(41, 360, Height),
                left: scaleCoordinates(385, 592, Width),
                height: scaleCoordinates(buttonSize - 17, 360, Height),
                width: scaleCoordinates(buttonSize - 17, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageEspecial1 = 'assets/calculadora/Button_Special.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageEspecial1 = 'assets/calculadora/pressedButton_Special.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Gol');
                        timelineReview.insert(0, green);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageEspecial1 = 'assets/calculadora/Button_Special.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageEspecial1),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/golIcon1.png'),
                    ),
                  ),
                ),
              ),
              //Especial Button 2
              Positioned(
                top: scaleCoordinates(41, 360, Height),
                left: scaleCoordinates(420, 592, Width),
                height: scaleCoordinates(buttonSize - 17, 360, Height),
                width: scaleCoordinates(buttonSize - 17, 592, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageEspecial2 = 'assets/calculadora/Button_Special.png';
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      imageEspecial2 = 'assets/calculadora/pressedButton_Special.png';
                      if (minutesStr != '00' || secondsStr != "00") {
                        timeline.insert(0, 'Assistência');
                        timelineReview.insert(0, green);
                        timestamps.insert(0, '$minutesStr:$secondsStr');
                      }
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageEspecial2 = 'assets/calculadora/Button_Special.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageEspecial2),
                      ),
                      //color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/calculadora/assistenciaIcon3.png'),
                    ),
                  ),
                ),
              ),

              //Undo Button
              Positioned(
                top: scaleCoordinates(80, 360, Height),
                left: scaleCoordinates(230, 512, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                width: scaleCoordinates(buttonSize, 512, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageUndo = 'assets/calculadora/undoButton.png';
                    });
                  },
                  onTapDown: (_) {
                    if (timeline.length > 0) {
                      setState(() {
                        imageUndo = 'assets/calculadora/undoButton_Pressed.png';
                        timeline.removeAt(0);
                        timelineReview.removeAt(0);
                        timestamps.removeAt(0);
                      });
                    }
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageUndo = 'assets/calculadora/undoButton.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage(imageUndo),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('Desfazer',
                              style: TextStyle(
                                  fontFamily: 'FontText',
                                  color: Colors.white,
                                  fontSize: 50)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Time
              Positioned(
                top: scaleCoordinates(41, 360, Height),
                left: scaleCoordinates(221, 512, Width),
                height: scaleCoordinates(buttonSize, 360, Height),
                width: scaleCoordinates(buttonSize + 20, 512, Width),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  //color: Colors.purple,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('$minutesStr:$secondsStr',
                          style: TextStyle(
                              fontFamily: 'FontRelogio',
                              color: Colors.white,
                              fontSize: 50)),
                    ),
                  ),
                ),
              ),
              //Quit Button
              Positioned(
                top: scaleCoordinates(41, 360, Height),
                left: scaleCoordinates(461, 512, Width),
                height: scaleCoordinates(buttonSize - 20, 360, Height),
                width: scaleCoordinates(buttonSize - 20, 512, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageStopWatch = 'assets/calculadora/quitButton.png';
                    });
                  },
                  onTapDown: (_) {
                    timerSubscription.cancel();
                    timerStream = null;
                    setState(() {
                      imageQuit = 'assets/calculadora/quitButton_Pressed.png';
                      minutesStr = '00';
                      secondsStr = '00';
                      savedTick = 0;
                      isCounting = false;
                    });
                  },
                  onTapUp: (_) {
                    if (timestamps.isNotEmpty) {
                      var result = new ResultsModel(
                          actionTimeline: timeline,
                          colorTimeline: timelineReview,
                          timestamp: timestamps);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              //new CadastroScreen(result)));
                              new ResultadoScreen(result)));
                    }

                    setState(() {
                      imageQuit = 'assets/calculadora/quitButton.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageQuit),
                      ),
                      //color: Colors.white
                    ),
                  ),
                ),
              ),
              //Start StopWatch
              Positioned(
                top: scaleCoordinates(41, 360, Height),
                left: scaleCoordinates(421, 512, Width),
                height: scaleCoordinates(buttonSize - 20, 360, Height),
                width: scaleCoordinates(buttonSize - 20, 512, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageStopWatch = 'assets/calculadora/quitButton.png';
                    });
                  },
                  onTapDown: (_) {
                    if (!isCounting) {
                      setState(() {
                        isCounting = true;
                      });
                      timerStream = stopWatchStream();
                      timerSubscription = timerStream.listen((int newTick) {
                        setState(() {
                          tick = newTick;
                          minutesStr = (((savedTick + newTick) / 60) % 60)
                              .floor()
                              .toString()
                              .padLeft(2, '0');
                          secondsStr = ((savedTick + newTick) % 60)
                              .floor()
                              .toString()
                              .padLeft(2, '0');
                        });
                      });
                    } else {
                      setState(() {
                        savedTick += tick;
                        isCounting = false;
                        timerSubscription.cancel();
                      });
                    }
                    setState(() {
                      imageStopWatch = 'assets/calculadora/quitButton_Pressed.png';
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageStopWatch = 'assets/calculadora/quitButton.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageStopWatch),
                      ),
                      //color: Colors.white
                    ),
                  ),
                ),
              ),
              //Timeline
              Positioned(
                top: scaleCoordinates(120, 360, Height),
                left: scaleCoordinates(210, 512, Width),
                height: scaleCoordinates(200, 360, Height),
                width: scaleCoordinates(91, 512, Width),
                child: Container(
                  //color: Colors.green,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemExtent: 20,
                    reverse: false,
                    scrollDirection: Axis.vertical,
                    itemCount: timeline.length,
                    itemBuilder: (context, index) {
                      return Container(
                        //color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              // color: Colors.blue,
                              width: scaleCoordinates(23, 512, Width),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  timestamps[index],
                                  style: TextStyle(
                                      fontFamily: "FontText",
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: scaleCoordinates(50, 512, Width),
                              // color: Colors.blue,
                              child: AutoSizeText(
                                timeline[index],
                                maxLines: 1,
                                minFontSize: 7,
                                style: TextStyle(
                                    color: timelineReview[index],
                                    fontFamily: "FontText",
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              //Help
              Positioned(
                top: scaleCoordinates(41, 360, Height),
                left: scaleCoordinates(15, 512, Width),
                height: scaleCoordinates(buttonSize - 20, 360, Height),
                width: scaleCoordinates(buttonSize - 20, 512, Width),
                child: GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      imageBlack = 'assets/calculadora/Button_Black.png';
                    });
                  },
                  onTapDown: (_) {
                    _showDialog(context);
                    setState(() {
                      imageBlack = 'assets/calculadora/pressedButton_Black.png';
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      imageBlack = 'assets/calculadora/Button_Black.png';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(imageBlack),
                      ),
                      //color: Colors.white
                    ),
                    child: Center(
                      child: AutoSizeText(
                        '?',
                        maxLines: 1,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Transform newMethod(
      double scaleCoordinates(
          dynamic originalx, dynamic originalwidth, dynamic currentwidth),
      double Height,
      double Width) {
    return Transform.rotate(
      angle: (pi / 180) * 90,
      child: Container(
        width: scaleCoordinates(100, 512, Height),
        height: scaleCoordinates(205, 360, Width),
        //color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 14),
              child: Text(
                '12:12',
                style: TextStyle(
                    fontSize: 8, fontFamily: "FonteText", color: Colors.white),
              ),
            ),
            Text(
              'asd',
              style: TextStyle(
                  fontSize: 10, fontFamily: "FonteText", color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

