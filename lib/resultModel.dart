//Modelo para ser passado adiante da tela de calculadora até os resultados

import 'package:flutter/cupertino.dart';

class ResultsModel {
  List<String> actionTimeline;
  List<Color> colorTimeline;
  List<String> timestamp;
  String nomeCampeonato = '';
  String posicao = '';
  String nomeTime = '';
  String timeAdversario = '';
  String local = '';
  String data = '';
  ResultsModel({this.actionTimeline, this.colorTimeline, this.timestamp});
}
