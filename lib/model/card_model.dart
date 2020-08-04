import 'package:flutter/material.dart';

///Model for card data
class CardModel {

  /// Card number.
  String card;

  /// Card expiration month.
  ///
  /// Should be in the format "MM". For example "08"
  String expMonth;

  /// Card expiration year.
  ///
  /// Should be in the format "YYYY". For example "2020"
  String expYear;

  /// Card CVV.
  String cardCvv;

  /// Card holder name.
  ///
  /// This field is required for WayForPay
  String cardHolder;

  CardModel(
  {@required this.card, @required this.expMonth, @required this.expYear, @required this.cardCvv, @required this.cardHolder});
}
