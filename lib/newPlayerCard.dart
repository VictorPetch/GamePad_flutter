import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ies_calculator/calculoNotas.dart';
import 'package:ies_calculator/main.dart';
import 'package:ies_calculator/resultModel.dart';
import 'package:ies_calculator/resultado_screen.dart';
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
  int notaPasse;
  int notaChute;
  int notaDesarme;
  int notaAssistencia; //n tem nota, eh só a quantidade de assistencias
  int notaGol; // N tem nota, é só a quantidade de gols
  int notaDrible;

  double notaPasseCalculo(String modalidade) {
    final TOTALPASSE = CALCULO_NOTAS[widget.results.idadeSeries]['TOTALPASSE'];
    final MODALIDADE_MULT = CALCULO_NOTAS['MODALIDADE'][modalidade];
    final PASSE_CERTO = CALCULO_NOTAS[widget.results.idadeSeries]['PASSECERTO'];
    final ASSISTENCIA =
        CALCULO_NOTAS[widget.results.idadeSeries]['ASSISTENCIA'];
    double notaPassesTotal;
    double notaPassesCertos;
    double porcentagemAcerto;
    double notaAssistencias;

    //Passe
    notaPassesTotal = actionsTotal[0] *
        10 /
        (TOTALPASSE *MODALIDADE_MULT);

    //Assistencias
    notaAssistencias = actionsTotal[3] * 10 / (ASSISTENCIA * MODALIDADE_MULT);

    if (actionsCorretas[0] == 0)
      notaPassesCertos = 0;
    else {
      //Passes Certos
      porcentagemAcerto = actionsCorretas[0] / actionsTotal[0];
      notaPassesCertos =
          (porcentagemAcerto) * 10 / (PASSE_CERTO * MODALIDADE_MULT);
    }

    if (notaPassesTotal > 10) notaPassesTotal = 10;
    if (notaAssistencias > 10) notaAssistencias = 10;
    if (notaPassesCertos > 10) notaPassesCertos = 10;

    return (notaPassesTotal + notaPassesCertos + notaAssistencias) / 3;
  }

  double notaChuteCalculo(String modalidade) {
    final TOTALCHUTES = CALCULO_NOTAS[widget.results.idadeSeries]['CHUTE'];
    final MODALIDADE_MULT = CALCULO_NOTAS['MODALIDADE'][modalidade];
    final CHUTECERTOS = CALCULO_NOTAS[widget.results.idadeSeries]['CHUTEAOGOL'];
    final GOL = CALCULO_NOTAS[widget.results.idadeSeries]['GOL'];
    double notaChutesTotal;
    double notaChutesCertos;
    double porcentagemAcerto;
    double notaGol;

    //Passe
    notaChutesTotal = actionsTotal[1] * 10 / (TOTALCHUTES * MODALIDADE_MULT);
    //Assistencias
    notaGol = actionsTotal[4] * 10 / (GOL * MODALIDADE_MULT);
    if (actionsCorretas[1] == 0)
      notaChutesCertos = 0;
    else {
      //Passes Certos
      porcentagemAcerto = actionsCorretas[0] / actionsTotal[0];
      notaChutesCertos =
          (porcentagemAcerto) * 10 / (CHUTECERTOS * MODALIDADE_MULT);
    }

    if (notaChutesTotal > 10) notaChutesTotal = 10;
    if (notaGol > 10) notaGol = 10;
    if (notaChutesCertos > 10) notaChutesCertos = 10;

    return (notaChutesTotal + notaChutesCertos + notaGol) / 3;
  }

  double notaDesarmeCalculo(String modalidade) {
    final TOTALDESARMES = CALCULO_NOTAS[widget.results.idadeSeries]['DESARMES'];
    final MODALIDADE_MULT = CALCULO_NOTAS['MODALIDADE'][modalidade];
    double notaDesarmesTotal;

    notaDesarmesTotal =
        actionsTotal[2] * 10 / (TOTALDESARMES * MODALIDADE_MULT);
    if (notaDesarmesTotal > 10) notaDesarmesTotal = 10;

    return notaDesarmesTotal;
  }

  double notaDribleCalculo(String modalidade) {
    final TOTALDRIBLES = CALCULO_NOTAS[widget.results.idadeSeries]['DRIBLES'];
    final DRIBLESCERTOS =
        CALCULO_NOTAS[widget.results.idadeSeries]['DRIBLESCERTOS'];
    final MODALIDADE_MULT = CALCULO_NOTAS['MODALIDADE'][modalidade];
    double notaDriblesTotal;
    double notaDriblesCertos;
    double porcentagemAcerto;

    notaDriblesTotal = actionsTotal[5] * 10 / (TOTALDRIBLES * MODALIDADE_MULT);
    if (actionsCorretas[5] == 0)
      notaDriblesCertos = 0;
    else {
      //Passes Certos
      porcentagemAcerto = actionsCorretas[5] / actionsTotal[5];
      notaDriblesCertos =
          (porcentagemAcerto) * 10 / (DRIBLESCERTOS * MODALIDADE_MULT);
    }

    if (notaDriblesTotal > 10) notaDriblesTotal = 10;
    if (notaDriblesCertos > 10) notaDriblesCertos = 10;

    return (notaDriblesCertos + notaDriblesTotal) / 2;
  }

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
    if (widget.results.modalidade.contains('Futebol') ||
        widget.results.modalidade.contains('Football')) {
      modalidade = 'FOOTBALL';
    } else if (widget.results.modalidade.contains('Futsal')) {
      modalidade = 'FUTSAL';
    } else
      modalidade = 'SOCIETY';

    notaPasse = notaPasseCalculo(modalidade).toInt();
    notaChute = notaChuteCalculo(modalidade).toInt();
    notaDrible = notaDribleCalculo(modalidade).toInt();
    notaDesarme = notaDesarmeCalculo(modalidade).toInt();

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
              color: Colors.black,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.65,
                      child: RepaintBoundary(
                        key: key,
                        child: Stack(
                          children: [
                            //Card Image
                            // #region
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.red,
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
                                // color: Colors.green,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: width * 0.8 * 0.07,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(3, (index) {
                                          var notas = [
                                            notaPasse,
                                            notaChute,
                                            notaDesarme,
                                          ];
                                          return Container(
                                            height: height * 0.04,
                                            child: Center(
                                              child: AutoSizeText(
                                                (notas[index])
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
                                      // color: Colors.blue,
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
                                      // color: Colors.red,
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
                                            this.actionsTotal[3],
                                            this.actionsTotal[4],
                                            notaDrible,
                                          ];
                                          return Container(
                                            height: height * 0.04,
                                            child: Center(
                                              child: AutoSizeText(
                                                (notas[index])
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
                                      // color: Colors.blue,
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
                                // color: Colors.blue,
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
                        ),
                      ),
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
                          // color: Colors.red,
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
                              onTap: () {
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
