import 'dart:convert';

PaResModel paResModelFromJson(String str) => PaResModel.fromJson(json.decode(str));

class PaResModel {
  PaResModel({
    this.paRes,
    this.md,
  });

  String paRes;
  String md;

  factory PaResModel.fromJson(Map<String, dynamic> json) => PaResModel(
    paRes: json["PaRes"],
    md: json["MD"],
  );

  Map<String, dynamic> toJson() => {
    "PaRes": paRes,
    "MD": md,
  };
}