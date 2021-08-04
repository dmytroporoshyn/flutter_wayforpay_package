import 'dart:convert';

WayForPayModel wayForPayModelFromJson(String str) =>
    WayForPayModel.fromJson(json.decode(str) as Map<String, dynamic>);

String wayForPayModelToJson(WayForPayModel data) => json.encode(data.toJson());

class WayForPayModel {
  WayForPayModel({
    this.transactionType,
    this.merchantAccount,
    this.merchantDomainName,
    this.merchantTransactionSecureType,
    this.merchantSignature,
    this.orderReference,
    this.apiVersion,
    this.orderDate,
    this.amount,
    this.currency,
    this.card,
    this.expMonth,
    this.expYear,
    this.cardCvv,
    this.cardHolder,
    this.productName,
    this.productPrice,
    this.productCount,
  });

  String? transactionType;
  String? merchantAccount;
  String? merchantDomainName;
  String? merchantTransactionSecureType;
  String? merchantSignature;
  String? orderReference;
  int? apiVersion;
  int? orderDate;
  dynamic amount;
  String? currency;
  String? card;
  String? expMonth;
  String? expYear;
  String? cardCvv;
  String? cardHolder;
  List<String>? productName;
  List<dynamic>? productPrice;
  List<int>? productCount;

  factory WayForPayModel.fromJson(Map<String, dynamic> json) => WayForPayModel(
        transactionType: json['transactionType'] != null
            ? json['transactionType'] as String
            : null,
        merchantAccount: json['merchantAccount'] != null
            ? json['merchantAccount'] as String
            : null,
        merchantDomainName: json['merchantDomainName'] != null
            ? json['merchantDomainName'] as String
            : null,
        merchantTransactionSecureType:
            json['merchantTransactionSecureType'] != null
                ? json['merchantTransactionSecureType'] as String
                : null,
        merchantSignature: json['merchantSignature'] != null
            ? json['merchantSignature'] as String
            : null,
        orderReference: json['orderReference'] != null
            ? json['orderReference'] as String
            : null,
        apiVersion:
            json['apiVersion'] != null ? json['apiVersion'] as int : null,
        orderDate: json['orderDate'] != null ? json['orderDate'] as int : null,
        amount: json['amount'] != null ? json['amount'] as dynamic : null,
        currency: json['currency'] != null ? json['currency'] as String : null,
        card: json['card'] != null ? json['card'] as String : null,
        expMonth: json['expMonth'] != null ? json['expMonth'] as String : null,
        expYear: json['expYear'] != null ? json['expYear'] as String : null,
        cardCvv: json['cardCvv'] != null ? json['cardCvv'] as String : null,
        cardHolder:
            json['cardHolder'] != null ? json['cardHolder'] as String : null,
        productName: json['productName'] != null
            ? List<String>.from((json['productName'] as List).map((x) => x))
            : null,
        productPrice: json['productPrice'] != null
            ? List<dynamic>.from((json['productPrice'] as List).map((x) => x))
            : null,
        productCount: json['productCount'] != null
            ? List<int>.from((json['productCount'] as List).map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'transactionType': transactionType,
        'merchantAccount': merchantAccount,
        'merchantDomainName': merchantDomainName,
        'merchantTransactionSecureType': merchantTransactionSecureType,
        'merchantSignature': merchantSignature,
        'orderReference': orderReference,
        'apiVersion': apiVersion,
        'orderDate': orderDate,
        'amount': amount,
        'currency': currency,
        'card': card,
        'expMonth': expMonth,
        'expYear': expYear,
        'cardCvv': cardCvv,
        'cardHolder': cardHolder,
        'productName': List<String>.from(productName!.map((x) => x)),
        'productPrice': List<dynamic>.from(productPrice!.map((x) => x)),
        'productCount': List<int>.from(productCount!.map((x) => x)),
      };
}
