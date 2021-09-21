import 'dart:convert';

WayForPayResponse wayForPayResponseFromJson(String str) =>
    WayForPayResponse.fromJson(json.decode(str) as Map<String, dynamic>);

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

  String? merchantAccount;
  String? authTicket;
  String? orderReference;
  String? merchantSignature;
  dynamic amount;
  String? currency;
  String? authCode;
  String? email;
  String? phone;
  int? createdDate;
  int? processingDate;
  String? cardPan;
  String? cardType;
  String? issuerBankCountry;
  String? issuerBankName;
  String? recToken;
  String? transactionStatus;
  String? reason;
  int? reasonCode;
  dynamic fee;
  String? paymentSystem;
  String? merchantTransactionType;
  String? d3AcsUrl;
  String? d3Md;
  String? d3Pareq;
  dynamic returnUrl;

  factory WayForPayResponse.fromJson(Map<String, dynamic> json) =>
      WayForPayResponse(
        merchantAccount: json['merchantAccount'] != null
            ? json['merchantAccount'] as String
            : null,
        authTicket:
            json['authTicket'] != null ? json['authTicket'] as String : null,
        orderReference: json['orderReference'] != null
            ? json['orderReference'] as String
            : null,
        merchantSignature: json['merchantSignature'] != null
            ? json['merchantSignature'] as String
            : null,
        amount: json['amount'] != null ? json['amount'] as dynamic : null,
        currency: json['currency'] != null ? json['currency'] as String : null,
        authCode: json['authCode'] != null ? json['authCode'] as String : null,
        email: json['email'] != null ? json['email'] as String : null,
        phone: json['phone'] != null ? json['phone'] as String : null,
        createdDate:
            json['createdDate'] != null ? json['createdDate'] as int : null,
        processingDate: json['processingDate'] != null
            ? json['processingDate'] as int
            : null,
        cardPan: json['cardPan'] != null ? json['cardPan'] as String : null,
        cardType: json['cardType'] != null ? json['cardType'] as String : null,
        issuerBankCountry: json['issuerBankCountry'] != null
            ? json['issuerBankCountry'] as String
            : null,
        issuerBankName: json['issuerBankName'] != null
            ? json['issuerBankName'] as String
            : null,
        recToken: json['recToken'] != null ? json['recToken'] as String : null,
        transactionStatus: json['transactionStatus'] != null
            ? json['transactionStatus'] as String
            : null,
        reason: json['reason'] != null ? json['reason'] as String : null,
        reasonCode:
            json['reasonCode'] != null ? json['reasonCode'] as int : null,
        fee: json['fee'] != null ? json['fee'] as dynamic : null,
        paymentSystem: json['paymentSystem'] != null
            ? json['paymentSystem'] as String
            : null,
        merchantTransactionType: json['merchantTransactionType'] != null
            ? json['merchantTransactionType'] as String
            : null,
        d3AcsUrl: json['d3AcsUrl'] != null ? json['d3AcsUrl'] as String : null,
        d3Md: json['d3Md'] != null ? json['d3Md'] as String : null,
        d3Pareq: json['d3Pareq'] != null ? json['d3Pareq'] as String : null,
        returnUrl:
            json['returnUrl'] != null ? json['returnUrl'] as dynamic : null,
      );

  Map<String, dynamic> toJson() => {
        'merchantAccount': merchantAccount,
        'authTicket': authTicket,
        'orderReference': orderReference,
        'merchantSignature': merchantSignature,
        'amount': amount,
        'currency': currency,
        'authCode': authCode,
        'email': email,
        'phone': phone,
        'createdDate': createdDate,
        'processingDate': processingDate,
        'cardPan': cardPan,
        'cardType': cardType,
        'issuerBankCountry': issuerBankCountry,
        'issuerBankName': issuerBankName,
        'recToken': recToken,
        'transactionStatus': transactionStatus,
        'reason': reason,
        'reasonCode': reasonCode,
        'fee': fee,
        'paymentSystem': paymentSystem,
        'merchantTransactionType': merchantTransactionType,
        'd3AcsUrl': d3AcsUrl,
        'd3Md': d3Md,
        'd3Pareq': d3Pareq,
        'returnUrl': returnUrl,
      };
}
