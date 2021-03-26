import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ies_calculator/calculoNotas.dart';
import 'package:ies_calculator/main.dart';
import 'package:ies_calculator/resultModel.dart';
import 'package:ies_calculator/utils/utils.dart';
import 'package:ies_calculator/utils/widget_to_image.dart';

// void main() => runApp(MaterialApp(home: PlayerCard(),));

var red = Colors.red;
const _cardHeight = 400.0;
const _cardWeight = _cardHeight * 0.6625;
const _firstRowHeight = _cardHeight * 0.48;
const _secondRowHeight = _cardHeight * 0.0875;
const _thirdRowHeight = _cardHeight * 0.4325;
const _statsRow_Height = _thirdRowHeight * 0.5;
const _margin1 = _cardHeight * 0.0025;
const _margin5 = _cardHeight * 0.0125;
const _margin8 = _cardHeight * 0.02;
const _margin10 = _cardHeight * 0.025;
const _margin11 = _cardHeight * 0.1075;
const _margin60 = _cardHeight * 0.15;
const _margin64 = _cardHeight * 0.16;
const _fontSize20 = _cardHeight * 0.05;
const _fontSize22 = _cardHeight * 0.035;
const _fontSize24 = _cardHeight * 0.065;
const _flagDimension = _cardHeight * 0.0875;
const _playerImageHeight = _cardHeight * 0.3375;

const statsValueStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: _fontSize22,
  fontFamily: 'Oswald',
);
const statsLabelStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: _fontSize22,
  fontFamily: 'Oswald',
);

class PlayerCard extends StatefulWidget {
  var results = ResultsModel();
  PlayerCard(this.results);
  //TODO usar isso depois
  // final String typeCard;
  // PlayerCard(this.typeCard);

  @override
  _PlayerCardScreenState createState() => _PlayerCardScreenState();
}

class _PlayerCardScreenState extends State<PlayerCard> {
  
  GlobalKey key;
  Uint8List bytes;
  bool _isShared = false;
  List<int> actionsTotal;
  List<int> actionsCorretas;

  @override
  void initState() {
    actionsTotal = [0, 0, 0, 0, 0, 0];
    actionsCorretas = [0, 0, 0, 0, 0, 0];
    for (var i = 0; i < widget.results.actionTimeline.length; i++) {
      setState(() {
        if (widget.results.actionTimeline[i] == 'Passe') {
          actionsTotal[0] += 1;
          if (widget.results.colorTimeline[i] == Color(0xff47ff84)) {
            actionsCorretas[0] += 1;
          }
        } else if (widget.results.actionTimeline[i] == 'Chute ao Gol') {
          actionsTotal[1] += 1;
          if (widget.results.colorTimeline[i] == Color(0xff47ff84)) {
            actionsCorretas[1] += 1;
          }
        } else if (widget.results.actionTimeline[i] == 'Desarme') {
          actionsTotal[2] += 1;
          if (widget.results.colorTimeline[i] == Color(0xff47ff84)) {
            actionsCorretas[2] += 1;
          }
        } else if (widget.results.actionTimeline[i] == 'Assistência') {
          actionsTotal[3] += 1;
          if (widget.results.colorTimeline[i] == Color(0xff47ff84)) {
            actionsCorretas[3] += 1;
          }
        } else if (widget.results.actionTimeline[i] == 'Gol') {
          actionsTotal[4] += 1;
          if (widget.results.colorTimeline[i] == Color(0xff47ff84)) {
            actionsCorretas[4] += 1;
          }
        } else if (widget.results.actionTimeline[i] == 'Drible') {
          actionsTotal[5] += 1;
          if (widget.results.colorTimeline[i] == Color(0xff47ff84)) {
            actionsCorretas[5] += 1;
          }
        }
      });
    }
    //TODO calcular a nota com base nas actions
    //Idade ta mockada pra 20
    //A regra de 3 eh: action * 10 / (nota da tabela * modalidade)
    String modalidade;
    if(widget.results.modalidade.contains('Futebol') || widget.results.modalidade.contains('Football')){
      modalidade = 'FOOTBALL';
    }
    else if(widget.results.modalidade.contains('Futsal')){
       modalidade = 'FUTSAL';
    }
    else modalidade = 'SOCIETY';

    //Passe
    double notaPasses = actionsTotal[0] * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['TOTALPASSE'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    double notaPassesCertos = (actionsCorretas[0]/actionsTotal[0]).toDouble() * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['PASSECERTO'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    if(actionsTotal[3] > 10) actionsTotal[3] = 10; //Eh 10+ assist pra tirar nota 10
    double notaAssistencias = actionsTotal[3] * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['ASSISTENCIA'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    //Gol
    double notaChutes = actionsTotal[0] * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['CHUTE'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    double notaChutesAoGol = (actionsCorretas[0]/actionsTotal[0]).toDouble() * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['CHUTEAOGOL'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);
    
    if(actionsTotal[3] > 10) actionsTotal[3] = 10; 
    double notaGol = actionsTotal[3] * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['GOL'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    //Desarmes
    if(actionsTotal[2] > 20) actionsTotal[2] = 20; 
    double notaDesarmes = actionsTotal[2] * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['DESARME'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    //Drible
    double notaDribles = actionsTotal[5] * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['DRIBLES'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    double notaDriblesCertos = (actionsCorretas[5]/actionsTotal[5]).toDouble() * 10 / 
    (CALCULO_NOTAS[widget.results.idadeSeries]['DRIBLESCERTOS'] * 
    CALCULO_NOTAS['MODALIDADE'][modalidade]);

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _pathImage = "assets/player_card/Group 10 copy 19.png";
    var width = MediaQuery.of(context).size.width;
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    print(height);
    // if(this.typeCard == "G") _pathImage = "assets/gold_rare.png";
    // if(this.typeCard == "S") _pathImage = "assets/silver_rare.png";
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(Icons.arrow_back),
        //   ),
        // ),
        body: Container(
          // color: Colors.black,
          child: Center(
            child: Container(
              height: height,
              width: width,
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.65,
                      child: WidgetToImage(builder: (key) {
                        return Stack(
                          children: [
                            //Card Image
                            // #region
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(_pathImage)),
                                ),
                              ),
                            ),
                            // #endregion

                            //Right
                            // #region
                            _isShared
                                ? Container()
                                : Positioned(
                                    right: width * 0.8 * 0.50,
                                    top: height * 0.65 * 0.19,
                                    child: Container(
                                      width: width * 0.8 * 0.10,
                                      height: height * 0.65 * 0.08,
                                      // color: Colors.red,
                                      child: IconButton(
                                        icon: Icon(Icons.share),
                                        onPressed: () {
                                          shareImage(bytes, key);
                                        },
                                      ),
                                    ),
                                  ),
                            Positioned(
                              right: width * 0.8 * 0.17,
                              top: height * 0.65 * 0.18,
                              child: Container(
                                  width: width * 0.8 * 0.36,
                                  height: height * 0.65 * 0.18,
                                  //color: Colors.red,
                                  child: Image.asset(
                                    "assets/messi.png",
                                    height: _playerImageHeight,
                                  )),
                            ),
                            Positioned(
                              right: width * 0.8 * 0.15,
                              top: height * 0.65 * 0.37,
                              child: Container(
                                width: width * 0.8 * 0.4,
                                height: height * 0.65 * 0.08,
                                //color: Colors.red,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        //color: Colors.green,
                                        child: Center(
                                            child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            "Jonathan Silva",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 50,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Oswald'),
                                          ),
                                        )),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.65 * 0.04,
                                      //color: Colors.blue,
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          "Goleiro",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 3,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Oswald'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.8 * 0.15,
                              top: height * 0.65 * 0.48,
                              child: Container(
                                width: width * 0.8 * 0.45,
                                height: height * 0.65 * 0.2,
                                color: Colors.green,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      width: width * 0.8 * 0.07,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(3, (index) {
                                          var notas = [
                                            this.actionsCorretas[0] > 0
                                                ? this.actionsCorretas[0] /
                                                    this.actionsTotal[0]
                                                : 0,
                                            this.actionsCorretas[1] > 0
                                                ? this.actionsCorretas[1] /
                                                    this.actionsTotal[1]
                                                : 0,
                                            this.actionsCorretas[2] > 0
                                                ? this.actionsCorretas[2] /
                                                    this.actionsTotal[2]
                                                : 0,
                                          ];
                                          return Container(
                                            height: height * 0.04,
                                            child: Center(
                                              child: AutoSizeText(
                                                (notas[index] * 10)
                                                    .toInt()
                                                    .toString(),
                                                maxLines: 1,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Oswald'),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.blue,
                                      width: width * 0.8 * 0.12,
                                      margin: EdgeInsets.only(
                                          left: width * 0.8 * 0.02),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(3, (index) {
                                            var actions = ['PSS', 'CHT', 'DES'];
                                            return Container(
                                              height: height * 0.04,
                                              child: Center(
                                                child: AutoSizeText(
                                                  actions[index],
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Oswald'),
                                                ),
                                              ),
                                            );
                                          })),
                                    ),
                                    Container(
                                      color: Colors.red,
                                      width: width * 0.8 * 0.07,
                                      margin: EdgeInsets.only(
                                          left: width * 0.8 * 0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(3, (index) {
                                          var notas = [
                                            this.actionsCorretas[3] > 0
                                                ? this.actionsCorretas[3] /
                                                    this.actionsTotal[3]
                                                : 0,
                                            this.actionsCorretas[4] > 0
                                                ? this.actionsCorretas[4] /
                                                    this.actionsTotal[4]
                                                : 0,
                                            this.actionsCorretas[5] > 0
                                                ? this.actionsCorretas[5] /
                                                    this.actionsTotal[5]
                                                : 0,
                                          ];
                                          return Container(
                                            height: height * 0.04,
                                            child: Center(
                                              child: AutoSizeText(
                                                (notas[index] * 10)
                                                    .toInt()
                                                    .toString(),
                                                maxLines: 1,
                                                minFontSize: 10,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Oswald'),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.8 * 0.12,
                                      color: Colors.blue,
                                      margin: EdgeInsets.only(
                                          left: width * 0.8 * 0.02),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(3, (index) {
                                            var actions = ['ASS', 'GOL', 'DRB'];
                                            return Container(
                                              height: height * 0.04,
                                              child: Center(
                                                child: AutoSizeText(
                                                  actions[index],
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Oswald'),
                                                ),
                                              ),
                                            );
                                          })),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // #endregion

                            //Bottom lines
                            // #region
                            Positioned(
                              right: width * 0.8 * 0.25,
                              bottom: height * 0.65 * 0.23,
                              child: Container(
                                width: width * 0.8 * 0.5,
                                height: height * 0.65 * 0.03,
                                // color: Colors.green,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: AutoSizeText(
                                    "SÃO PAULO/SP - 03/08/2021",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    minFontSize: 4,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Oswald'),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.8 * 0.275,
                              bottom: height * 0.65 * 0.20,
                              child: Container(
                                width: width * 0.8 * 0.45,
                                height: height * 0.65 * 0.03,
                                color: Colors.blue,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "CAMPEONATO DA CACHOEIRINHA",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Oswald'),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.8 * 0.35,
                              bottom: height * 0.65 * 0.165,
                              child: Container(
                                width: width * 0.8 * 0.3,
                                height: height * 0.65 * 0.03,
                                // color: Colors.red,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: AutoSizeText(
                                    "TIME DA CIDADE",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    minFontSize: 4,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Oswald'),
                                  ),
                                ),
                              ),
                            ),
                            // #endregion

                            //Left
                            // #region
                            Positioned(
                              left: width * 0.8 * 0.17,
                              top: height * 0.65 * 0.18,
                              child: Container(
                                width: width * 0.8 * 0.2,
                                height: height * 0.65 * 0.1,
                                //color: Colors.red,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "42",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 41,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Oswald'),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: width * 0.8 * 0.17,
                              top: height * 0.65 * 0.3,
                              child: Container(
                                width: width * 0.8 * 0.2,
                                height: height * 0.65 * 0.1,
                                //color: Colors.blue,
                              ),
                            ),
                            Positioned(
                              left: width * 0.8 * 0.2,
                              top: height * 0.65 * 0.43,
                              child: Container(
                                width: width * 0.8 * 0.14,
                                height: height * 0.65 * 0.25,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/player_card/Slice1.png')),
                                ),
                              ),
                            ),
                            // #endregion
                          ],
                        );
                      }),
                    ),
                  ),
                  //Buttons
                  Align(
                    alignment: Alignment(0, 0.7),
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.13,
                      padding: EdgeInsets.fromLTRB(width * 0.1, height * 0.03,
                          width * 0.1, height * 0.03),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  'assets/player_card/buttonsBase.png'))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                  'assets/player_card/backButton.png')),
                          GestureDetector(
                            onTap: (){
                              shareImage(bytes, key);
                            },
                              child: Image.asset(
                                  'assets/player_card/shareButton.png')),
                          Image.asset('assets/player_card/downloadButton.png'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void shareImage(Uint8List bytes, GlobalKey key) async {
    setState(() {
      _isShared = true;
    });
    final tempBytes = await Utils.capture(key);
    setState(() {
      bytes = tempBytes;
    });
    await Utils.createFileFromString(bytes);

    setState(() {
      _isShared = false;
      bytes = null;
    });
  }
}
