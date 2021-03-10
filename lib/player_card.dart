import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ies_calculator/main.dart';
import 'package:ies_calculator/utils/utils.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ies_calculator/utils/widget_to_image.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MaterialApp(
          home: MaterialApp(home: PlayerCard()),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        ), // Wrap your app
      ),
    );

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

  @override
  Widget build(BuildContext context) {
    String _pathImage = "assets/card_calculadora/gold.png";
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print(height);
    // if(this.typeCard == "G") _pathImage = "assets/gold_rare.png";
    // if(this.typeCard == "S") _pathImage = "assets/silver_rare.png";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Container(
              height: _cardHeight,
              width: _cardWeight,
              color: Colors.black,
              child: WidgetToImage(builder: (key) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        image: DecorationImage(image: AssetImage(_pathImage)),
                      ),
                    ),
                    _isShared
                        ? Container()
                        : Positioned(
                          top: 160,
                          left: 35,
                          child: InkWell(
                            onTap: () {
                              shareImage(bytes, key);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20, bottom: 20),
                              height: height * 0.055,
                              width: width * 0.2,
                              child: Icon(Icons.share, color: Colors.black54),
                            ),
                          ),
                        ),
                    Column(
                      children: [
                        //top info
                        // #region
                        Container(
                          //color: green,
                          height: 110,
                          margin: EdgeInsets.only(top: 50),
                          // padding:
                          //     const EdgeInsets.symmetric(horizontal: _margin11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                //color: red,
                                margin: EdgeInsets.only(
                                  top: _margin60 * 0.1,
                                  left: _margin10 * 6,
                                  // right: _margin10,
                                  // bottom: _margin10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("93",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: _fontSize24)),
                                    Text("RW",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: _fontSize22)),
                                    Image.asset("assets/argentina.png",
                                        alignment: Alignment.center,
                                        fit: BoxFit.fill,
                                        width: _flagDimension),
                                    Image.asset("assets/barcelona.png",
                                        alignment: Alignment.center,
                                        fit: BoxFit.fill,
                                        width: _flagDimension)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    ////color: Colors.blue,
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(right: _margin10*2,bottom: 10,),
                                    child: Image.asset(
                                      "assets/messi.png",
                                      height: _playerImageHeight,
                                    )),
                              )
                            ],
                          ),
                        ),
                        // #endregion

                        //Nome
                        // #region
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Container(
                              // color: red,
                              height: _secondRowHeight * 1.7,
                              width: width * 0.3,
                              margin: EdgeInsets.only(
                                  right: _margin11*0.85, left: _margin64 * 0.3),
                              child: Column(
                                children: [
                                  Container(
                                    // color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(_margin1),
                                      child: Center(
                                          child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          "Jonathan Silva",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: _fontSize20,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Oswald'),
                                        ),
                                      )),
                                    ),
                                  ),
                                  Container(
                                    //color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(_margin1),
                                      child: Center(
                                          child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          "Goleiro",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: _fontSize20,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Oswald'),
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // #endregion

                        //botton right info
                        // #region
                        Container(
                          // color: Colors.blue,
                          height: _thirdRowHeight * 0.5,
                          margin: EdgeInsets.only(
                              right: _margin11, left: _margin64 * 1.6),
                          // padding: EdgeInsets.all(_margin8),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: _statsRow_Height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  //color: red,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("99", style: statsValueStyle),
                                      Text("99", style: statsValueStyle),
                                      Text("99", style: statsValueStyle),
                                    ],
                                  ),
                                ),
                                Container(
                                  //color: red,
                                  margin: EdgeInsets.only(left: _margin5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("PAC", style: statsLabelStyle),
                                      Text("SHO", style: statsLabelStyle),
                                      Text("PAS", style: statsLabelStyle),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: _margin10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("99", style: statsValueStyle),
                                      Text("99", style: statsValueStyle),
                                      Text("10", style: statsValueStyle),
                                    ],
                                  ),
                                ),
                                Container(
                                  //color: Colors.red,
                                  margin: EdgeInsets.only(left: _margin5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("DRI", style: statsLabelStyle),
                                      Text("DEF", style: statsLabelStyle),
                                      Text("PHY", style: statsLabelStyle),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // #endregion

                        Container(
                          // color: red,
                          width: 120,
                          height: 80,
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "SÃO PAULO/SP - 03/08/2021",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Oswald'),
                                ),
                              ),
                              FittedBox(
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
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "TIME DA CIDADE",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Oswald'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
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
