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
    var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
              child: WidgetToImage(builder: (key) {
                return Stack(
                  children: [
                    Center(
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          ////color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fill, image: AssetImage(_pathImage)),
                        ),
                      ),
                    ),

                    // #region Right
                    _isShared ? 
                    Container():
                    Positioned(
                      right: width*0.50,
                      top: height*0.19,
                      child: Container(
                      width: width*0.10,
                      height: height*0.08,
                      // color: Colors.red,
                      child: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: (){
                          shareImage(bytes,key);
                        },
                      ),
                      ),
                    ),
                    Positioned(
                      right: width * 0.17,
                      top: height * 0.18,
                      child: Container(
                          width: width * 0.36,
                          height: height * 0.18,
                          //color: Colors.red,
                          child: Image.asset(
                            "assets/messi.png",
                            height: _playerImageHeight,
                          )),
                    ),
                    Positioned(
                      right: width * 0.15,
                      top: height * 0.37,
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.08,
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
                              height: height * 0.04,
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
                      right: width * 0.15,
                      top: height * 0.48,
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.2,
                        // color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(3,(index){
                                  return  Text(
                                    "10",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Oswald'),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(3,(index){
                                  return  Text(
                                    "AAA",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Oswald'),
                                  );
                                })
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(3,(index){
                                  return  Text(
                                    "10",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Oswald'),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(3,(index){
                                  return  Text(
                                    "AAA",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Oswald'),
                                  );
                                })
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // #endregion

                    // #region Bottom lines
                    Positioned(
                      right: width * 0.25,
                      top: height * 0.73,
                      child: Container(
                        width: width * 0.5,
                        height: height * 0.02,
                        //color: Colors.green,
                        child: FittedBox(
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
                      ),
                    ),
                    Positioned(
                      right: width * 0.275,
                      top: height * 0.75,
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.02,
                        //color: Colors.blue,
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
                      right: width * 0.35,
                      top: height * 0.77,
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.02,
                        //color: Colors.red,
                        child: FittedBox(
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
                      ),
                    ),
                    // #endregion

                    // #region Left
                    Positioned(
                      left: width * 0.17,
                      top: height * 0.18,
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.1,
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
                      left: width * 0.17,
                      top: height * 0.3,
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.1,
                        //color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      left: width * 0.2,
                      top: height * 0.43,
                      child: Container(
                        width: width * 0.14,
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/player_card/Slice1.png')
                          ),
                          
                        ),
                      ),
                    ),
                    // #endregion
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
