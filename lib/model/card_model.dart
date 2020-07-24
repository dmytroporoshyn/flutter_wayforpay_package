import 'package:flutter/material.dart';

class CardModel {
  String card;
  String expMonth;
  String expYear;
  String cardCvv;
  String cardHolder;

  CardModel(
  {@required this.card, @required this.expMonth, @required this.expYear, @required this.cardCvv, @required this.cardHolder});
}
