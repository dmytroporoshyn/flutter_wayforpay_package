import 'dart:convert';

String verify3DsModelToJson(Verify3DsModel data) => json.encode(data.toJson());

class Verify3DsModel {
  Verify3DsModel({
    this.transactionType,
    this.authorizationTicket,
    this.d3DsMd,
    this.apiVersion,
    this.d3DsPares,
  });

  String? transactionType;
  String? authorizationTicket;
  String? d3DsMd;
  int? apiVersion;
  String? d3DsPares;

  factory Verify3DsModel.fromJson(Map<String, dynamic> json) => Verify3DsModel(
    transactionType: json["transactionType"],
    authorizationTicket: json["authorization_ticket"],
    d3DsMd: json["d3ds_md"],
    apiVersion: json["apiVersion"],
    d3DsPares: json["d3ds_pares"],
  );

  Map<String, dynamic> toJson() => {
    "transactionType": transactionType,
    "authorization_ticket": authorizationTicket,
    "apiVersion": apiVersion,
    "d3ds_md": d3DsMd,
    "d3ds_pares": d3DsPares,
  };
}