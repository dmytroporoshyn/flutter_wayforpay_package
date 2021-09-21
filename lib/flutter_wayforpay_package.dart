library flutter_wayforpay_package;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wayforpay_package/model/card_model.dart';
import 'package:flutter_wayforpay_package/model/pares_model.dart';
import 'package:flutter_wayforpay_package/model/verify_3ds_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_wayforpay_package/repository/wayforpay_repository.dart';
import 'package:flutter_wayforpay_package/utils/constants.dart';
import 'package:flutter_wayforpay_package/utils/types.dart';
import 'package:flutter_wayforpay_package/verification_screen.dart';

import 'card_enter_screen.dart';

class WayForPay {
  /// Transaction type
  ///
  /// For normal payment processing is used [TransactionType.CHARGE]
  String transactionType = TransactionType.CHARGE;

  /// Merchant account
  ///
  /// This field is required
  /// Default test value 'test_merch_n1'
  String merchantAccount = 'test_merch_n1';

  /// Merchant secret key
  ///
  /// This field is required
  /// Default test value 'flk3409refn54t54t*FNJRET'
  String merchantSecretKey = 'flk3409refn54t54t*FNJRET';

  /// Merchant domain name
  ///
  /// This field is required
  /// Default value 'www.market.ua'
  String merchantDomainName = 'www.market.ua';

  /// WayForPay repository
  WayForPayRepository wayForPayRepository = WayForPayRepository();

  /// API version
  ///
  /// Default value [Constants.apiVersion]
  /// Don't change this value, if not needed
  int apiVersion = Constants.apiVersion;

  /// List of products names
  List<String>? productName;

  /// List of products prices
  List<dynamic>? productPrice;

  /// List of products counts
  List<int>? productCount;

  /// Open CardEnterScreen
  ///
  /// [amount] the amount of payment.
  /// [currencyType] the currency type, default value [CurrencyType.UAH].
  /// [merchantTransactionSecureType] the transaction secure type, default value [MerchantTransactionSecureType.AUTO].
  /// [orderReference] the unique order id, cannot be duplicated, recommend to use uuid.
  /// [orderDate] order date, it can be is past
  Future<WayForPayResponse?> openCardEnterScreen(BuildContext context,
      {required dynamic amount,
      String currencyType = CurrencyType.UAH,
      String merchantTransactionSecureType = MerchantTransactionSecureType.AUTO,
      required String orderReference,
      required DateTime orderDate}) async {
    var wayForPayResponse = (await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardEnterScreen(
          wayForPay: this,
          merchantTransactionSecureType: merchantTransactionSecureType,
          amount: amount,
          currencyType: currencyType,
          orderDate: orderDate,
          orderReference: orderReference,
        ),
        fullscreenDialog: true,
      ),
    )) as WayForPayResponse?;
    return wayForPayResponse;
  }

  /// Start payment process
  ///
  /// [cardModel] the card model with card data
  /// [amount] the amount of payment.
  /// [currencyType] the currency type, default value [CurrencyType.UAH].
  /// [merchantTransactionSecureType] the transaction secure type, default value [MerchantTransactionSecureType.AUTO].
  /// [orderReference] the unique order id, cannot be duplicated, recommend to use uuid.
  /// [orderDate] order date, it can be is past.
  Future<WayForPayResponse> makePayment(BuildContext context,
      {required CardModel cardModel,
      required dynamic amount,
      String currencyType = CurrencyType.UAH,
      String merchantTransactionSecureType =
          MerchantTransactionSecureType.NON3DS,
      required String orderReference,
      required DateTime orderDate}) async {
    var merchantSignature = makeSignature(
        productName: productName!,
        orderDate: orderDate,
        amount: amount,
        currencyType: currencyType,
        merchantAccount: merchantAccount,
        merchantDomainName: merchantDomainName,
        orderReference: orderReference,
        productCount: productCount!,
        productPrice: productPrice!);
    var wayForPayModel = WayForPayModel(
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
    var wayForPayResponse =
        await wayForPayRepository.fetchWayForPayResponse(wayForPayModel);
    switch (wayForPayResponse.transactionStatus) {
      case TransactionStatus.Approved:
        return wayForPayResponse;
      case TransactionStatus.InProcessing:
        if (wayForPayResponse.reasonCode == 5100) {
          return open3dsVerification(context, wayForPayResponse);
        } else {
          return wayForPayResponse;
        }
      case TransactionStatus.Declined:
        return wayForPayResponse;
      default:
        return wayForPayResponse;
    }
  }

  Future<WayForPayResponse> open3dsVerification(
      BuildContext context, WayForPayResponse wayForPayResponse) async {
    var paResModel = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => VerificationScreen(
        wayForPayResponse: wayForPayResponse,
      ),
    ));

    if (paResModel != null && paResModel is PaResModel) {
      var verifyModel = Verify3DsModel(
          authorizationTicket: wayForPayResponse.authTicket,
          d3DsMd: wayForPayResponse.d3Md,
          d3DsPares: paResModel.paRes,
          apiVersion: apiVersion,
          transactionType: TransactionType.COMPLETE_3DS);
      return await wayForPayRepository.verify3dsSecure(verifyModel);
    } else {
      throw Exception();
    }
  }

  String makeSignature(
      {required List<String> productName,
      required List<dynamic> productPrice,
      required List<int> productCount,
      String? merchantAccount,
      String? merchantDomainName,
      String? currencyType,
      String? orderReference,
      required DateTime orderDate,
      dynamic amount}) {
    var cipherText =
        '$merchantAccount;$merchantDomainName;$orderReference;${orderDate.millisecondsSinceEpoch};$amount;$currencyType';
    var names = productName.join(';');
    var prices = productPrice.join(';');
    var counts = productCount.join(';');
    cipherText += ';$names';
    cipherText += ';$counts';
    cipherText += ';$prices';

    var key = utf8.encode(merchantSecretKey);
    var bytes = utf8.encode(cipherText);
    var hmacSha256 = Hmac(md5, key);
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}
