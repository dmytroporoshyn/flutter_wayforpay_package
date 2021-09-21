import 'dart:convert';

PaResModel paResModelFromJson(String str) =>
    PaResModel.fromJson(json.decode(str) as Map<String, dynamic>);

class PaResModel {
  PaResModel({
    this.paRes,
    this.md,
  });

  String? paRes;
  String? md;

  factory PaResModel.fromJson(Map<String, dynamic> json) => PaResModel(
        paRes: json['PaRes'] != null ? json['PaRes'] as String : null,
        md: json['MD'] != null ? json['MD'] as String : null,
      );

  Map<String, dynamic> toJson() => {
        'PaRes': paRes,
        'MD': md,
      };
}
