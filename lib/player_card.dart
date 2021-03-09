import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ies_calculator/utils/utils.dart';
import 'package:ies_calculator/utils/widget_to_image.dart';

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
const _margin11 = _cardHeight * 0.0275;
const _margin60 = _cardHeight * 0.15;
const _margin64 = _cardHeight * 0.16;
const _fontSize20 = _cardHeight * 0.05;
const _fontSize22 = _cardHeight * 0.055;
const _fontSize24 = _cardHeight * 0.065;
const _flagDimension = _cardHeight * 0.0875;
const _playerImageHeight = _cardHeight * 0.3375;

const statsValueStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: _fontSize22);
const statsLabelStyle = TextStyle(fontSize: _fontSize22);

class PlayerCard extends StatefulWidget {
  final String typeCard;
  PlayerCard(this.typeCard);

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
    // if(this.typeCard == "G") _pathImage = "assets/gold_rare.png";
    // if(this.typeCard == "S") _pathImage = "assets/silver_rare.png";
    return Container(
      height: _cardHeight,
      width: _cardWeight,
      child: WidgetToImage(builder: (key) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(_pathImage)),
              ),
            ),
            _isShared
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            _isShared = true;
                          });
                          final bytes = await Utils.capture(key);
                          setState(() {
                            this.bytes = bytes;
                          });
                          await Utils.createFileFromString(bytes);

                          setState(() {
                            _isShared = false;
                            this.bytes = null;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20, bottom: 20),
                          height: height * 0.055,
                          width: width * 0.2,
                          child: Icon(Icons.share, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
            Column(
              children: [
                Container(
                  height: _firstRowHeight,
                  padding: const EdgeInsets.symmetric(horizontal: _margin11),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: _margin60,
                            left: _margin10,
                            right: _margin10,
                            bottom: _margin10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(right: _margin10),
                            child: Image.asset(
                              "assets/messi.png",
                              height: _playerImageHeight,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: _secondRowHeight,
                  child: Container(
                    margin: EdgeInsets.only(right: _margin11, left: _margin64),
                    child: Padding(
                      padding: const EdgeInsets.all(_margin1),
                      child: Center(
                          child: Text(
                        "MESSI",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: _fontSize20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                Container(
                  height: _thirdRowHeight,
                  margin: EdgeInsets.only(right: _margin11, left: _margin64),
                  padding: EdgeInsets.all(_margin8),
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: _statsRow_Height,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("99", style: statsValueStyle),
                                Text("99", style: statsValueStyle),
                                Text("99", style: statsValueStyle),
                              ],
                            ),
                            Container(
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
                            )
                          ],
                        ),
                        Row(
                          children: [
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
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
