library flutter_wayforpay_package;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wayforpay_package/model/card_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_model.dart';
import 'package:flutter_wayforpay_package/repository/wayforpay_repository.dart';
import 'package:flutter_wayforpay_package/utils/constants.dart';
import 'package:flutter_wayforpay_package/utils/types.dart';
import 'package:flutter_wayforpay_package/verification_screen.dart';

class WayForPay {
  String transactionType = TransactionType.CHARGE;
  String merchantAccount = "test_merch_n1";
  String merchantSecretKey = "flk3409refn54t54t*FNJRET";
  String merchantDomainName = "www.market.ua";
  WayForPayRepository wayForPayRepository = WayForPayRepository();

  int apiVersion = Constants.apiVersion;

  List<String> productName;
  List<dynamic> productPrice;
  List<int> productCount;

  void makePayment(BuildContext context,
      {@required CardModel cardModel,
      @required dynamic amount,
      String currencyType = CurrencyType.UAH,
      String merchantTransactionSecureType = MerchantTransactionSecureType.AUTO,
      @required String orderReference,
      @required DateTime orderDate}) async {
    String merchantSignature = makeSignature(
        productName: productName,
        orderDate: orderDate,
        amount: amount,
        currencyType: currencyType,
        merchantAccount: merchantAccount,
        merchantDomainName: merchantDomainName,
        orderReference: orderReference,
        productCount: productCount,
        productPrice: productPrice);
    WayForPayModel wayForPayModel = WayForPayModel(
        merchantAccount: merchantAccount,
        transactionType: transactionType,
        merchantDomainName: merchantDomainName,
        amount: amount,
        productPrice: productPrice,
        expYear: cardModel.expYear,
        expMonth: cardModel.expMonth,
        cardHolder: cardModel.cardHolder,
        cardCvv: cardModel.cardCvv,
        card: cardModel.card,
        productCount: productCount,
        orderReference: orderReference,
        orderDate: orderDate.millisecondsSinceEpoch,
        productName: productName,
        apiVersion: apiVersion,
        currency: currencyType,
        merchantSignature: merchantSignature,
        merchantTransactionSecureType: merchantTransactionSecureType);
    wayForPayRepository.fetchWayForPayResponse(wayForPayModel).then((value) {
      print(value);
      wayForPayRepository
          .fetch3DResponse(value.d3AcsUrl, value.d3Md, value.d3Pareq)
          .then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerificationScreen(url: value.body,),
        ));
      });
      print(value.d3Pareq);
    });
  }

  String makeSignature(
      {List<String> productName,
      List<dynamic> productPrice,
      List<int> productCount,
      String merchantAccount,
      String merchantDomainName,
      String currencyType,
      String orderReference,
      @required DateTime orderDate,
      dynamic amount}) {
    String cipherText =
        "$merchantAccount;$merchantDomainName;$orderReference;${orderDate.millisecondsSinceEpoch};$amount;$currencyType";
    String names = productName.join(";");
    String prices = productPrice.join(";");
    String counts = productCount.join(";");
    cipherText += ";$names";
    cipherText += ";$counts";
    cipherText += ";$prices";

    print(cipherText);

    var key = utf8.encode(merchantSecretKey);
    var bytes = utf8.encode(cipherText);
    var hmacSha256 = new Hmac(md5, key);
    var digest = hmacSha256.convert(bytes);

    print(digest.toString());

    return digest.toString();
  }
}
