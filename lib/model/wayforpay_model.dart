import 'dart:convert';

WayForPayModel wayForPayModelFromJson(String str) =>
    WayForPayModel.fromJson(json.decode(str));

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

  String transactionType;
  String merchantAccount;
  String merchantDomainName;
  String merchantTransactionSecureType;
  String merchantSignature;
  String orderReference;
  int apiVersion;
  int orderDate;
  dynamic amount;
  String currency;
  String card;
  String expMonth;
  String expYear;
  String cardCvv;
  String cardHolder;
  List<String> productName;
  List<dynamic> productPrice;
  List<int> productCount;

  factory WayForPayModel.fromJson(Map<String, dynamic> json) => WayForPayModel(
        transactionType: json["transactionType"],
        merchantAccount: json["merchantAccount"],
        merchantDomainName: json["merchantDomainName"],
        merchantTransactionSecureType: json["merchantTransactionSecureType"],
        merchantSignature: json["merchantSignature"],
        orderReference: json["orderReference"],
        apiVersion: json["apiVersion"],
        orderDate: json["orderDate"],
        amount: json["amount"],
        currency: json["currency"],
        card: json["card"],
        expMonth: json["expMonth"],
        expYear: json["expYear"],
        cardCvv: json["cardCvv"],
        cardHolder: json["cardHolder"],
        productName: List<String>.from(json["productName"].map((x) => x)),
        productPrice: List<dynamic>.from(json["productPrice"].map((x) => x)),
        productCount: List<int>.from(json["productCount"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "transactionType": transactionType,
        "merchantAccount": merchantAccount,
        "merchantDomainName": merchantDomainName,
        "merchantTransactionSecureType": merchantTransactionSecureType,
        "merchantSignature": merchantSignature,
        "orderReference": orderReference,
        "apiVersion": apiVersion,
        "orderDate": orderDate,
        "amount": amount,
        "currency": currency,
        "card": card,
        "expMonth": expMonth,
        "expYear": expYear,
        "cardCvv": cardCvv,
        "cardHolder": cardHolder,
        "productName": List<String>.from(productName.map((x) => x)),
        "productPrice": List<dynamic>.from(productPrice.map((x) => x)),
        "productCount": List<int>.from(productCount.map((x) => x)),
      };
}
