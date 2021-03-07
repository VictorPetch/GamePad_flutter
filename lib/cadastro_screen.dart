import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ies_calculator/resultModel.dart';

//This main is to be used when you want to test different screen sizes
// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MaterialApp(
//           home: CadastroScreen(),
//           locale: DevicePreview.locale(context),
//           builder: DevicePreview.appBuilder,
//         ), // Wrap your app
//       ),
//     );

// void main() => runApp(CadastroScreen());

String nomeCampeonato;
String posicao;
String nomeTime;
String timeAdversario;
String local;
String data;

// ignore: must_be_immutable
class CadastroScreen extends StatefulWidget {
  ResultsModel results = new ResultsModel();
  CadastroScreen(this.results);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
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

    print('dev $width $height $safeAreaBottom $safeAreaTop');

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

                  // #region Buttons
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 35),
                    width: width * 0.65,
                    height: height * 0.56,
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          mainButton(width, height, 'green', posicao, 10,'Nome do campeonato'),
                          mainButton(width, height, 'green', posicao, 10,'Posição jogada'),
                          mainButton(width, height, 'gray', posicao, 10,'Nome do time'),
                          mainButton(width, height, 'gray', posicao, 10,'Time adversário (opcional)'),
                          mainButton(width, height, 'gray', posicao, 10,'Local do jogo (opcional)'),
                          mainButton(width, height, 'green', posicao, 0,'Data do jogo'),
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
                        onTap: () {
                          //TODO levar pra results page
                          print('asd');
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 50, bottom: 20),
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

  // #region mainButton
  Container mainButton(double width, double height, String color,
      String controller, double bottomPadding,String hintText) {
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
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          validator: (text) {
            if (text.isEmpty) {
              return 'algum texto';
            } else {
              setState(() {
                controller = text;
              });
              return null;
            }
          },
        ),
      ),
    );
  }
  // #endregion
}

