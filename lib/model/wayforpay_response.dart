import 'dart:convert';

WayForPayResponse wayForPayResponseFromJson(String str) =>
    WayForPayResponse.fromJson(json.decode(str));

String wayForPayResponseToJson(WayForPayResponse data) =>
    json.encode(data.toJson());

class WayForPayResponse {
  WayForPayResponse({
    this.merchantAccount,
    this.authTicket,
    this.orderReference,
    this.merchantSignature,
    this.amount,
    this.currency,
    this.authCode,
    this.email,
    this.phone,
    this.createdDate,
    this.processingDate,
    this.cardPan,
    this.cardType,
    this.issuerBankCountry,
    this.issuerBankName,
    this.recToken,
    this.transactionStatus,
    this.reason,
    this.reasonCode,
    this.fee,
    this.paymentSystem,
    this.merchantTransactionType,
    this.d3AcsUrl,
    this.d3Md,
    this.d3Pareq,
    this.returnUrl,
  });

  String merchantAccount;
  String authTicket;
  String orderReference;
  String merchantSignature;
  dynamic amount;
  String currency;
  String authCode;
  String email;
  String phone;
  int createdDate;
  int processingDate;
  String cardPan;
  String cardType;
  String issuerBankCountry;
  String issuerBankName;
  String recToken;
  String transactionStatus;
  String reason;
  int reasonCode;
  dynamic fee;
  String paymentSystem;
  String merchantTransactionType;
  String d3AcsUrl;
  String d3Md;
  String d3Pareq;
  dynamic returnUrl;

  factory WayForPayResponse.fromJson(Map<String, dynamic> json) =>
      WayForPayResponse(
        merchantAccount: json["merchantAccount"],
        authTicket: json["authTicket"],
        orderReference: json["orderReference"],
        merchantSignature: json["merchantSignature"],
        amount: json["amount"],
        currency: json["currency"],
        authCode: json["authCode"],
        email: json["email"],
        phone: json["phone"],
        createdDate: json["createdDate"],
        processingDate: json["processingDate"],
        cardPan: json["cardPan"],
        cardType: json["cardType"],
        issuerBankCountry: json["issuerBankCountry"],
        issuerBankName: json["issuerBankName"],
        recToken: json["recToken"],
        transactionStatus: json["transactionStatus"],
        reason: json["reason"],
        reasonCode: json["reasonCode"],
        fee: json["fee"],
        paymentSystem: json["paymentSystem"],
        merchantTransactionType: json["merchantTransactionType"],
        d3AcsUrl: json["d3AcsUrl"],
        d3Md: json["d3Md"],
        d3Pareq: json["d3Pareq"],
        returnUrl: json["returnUrl"],
      );

  Map<String, dynamic> toJson() =>
      {
        "merchantAccount": merchantAccount,
        "authTicket": authTicket,
        "orderReference": orderReference,
        "merchantSignature": merchantSignature,
        "amount": amount,
        "currency": currency,
        "authCode": authCode,
        "email": email,
        "phone": phone,
        "createdDate": createdDate,
        "processingDate": processingDate,
        "cardPan": cardPan,
        "cardType": cardType,
        "issuerBankCountry": issuerBankCountry,
        "issuerBankName": issuerBankName,
        "recToken": recToken,
        "transactionStatus": transactionStatus,
        "reason": reason,
        "reasonCode": reasonCode,
        "fee": fee,
        "paymentSystem": paymentSystem,
        "merchantTransactionType": merchantTransactionType,
        "d3AcsUrl": d3AcsUrl,
        "d3Md": d3Md,
        "d3Pareq": d3Pareq,
        "returnUrl": returnUrl,
      };
}
