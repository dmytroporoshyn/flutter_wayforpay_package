import 'dart:convert';

import 'package:flutter_wayforpay_package/model/wayforpay_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:http/http.dart';

class WayforpayProvider {
  Client client = Client();

  Future<WayForPayResponse> fetchWayForPayResponse(
      WayForPayModel wayForPayModel) async {
    final response = await client
        .post("https://api.wayforpay.com/api",
            body: wayForPayModelToJson(wayForPayModel))
        .timeout(const Duration(seconds: 10))
        .catchError((e) {
      throw Exception('Failed to load post');
    });
    if (response.statusCode == 200) {
      print(response.body);
      return wayForPayResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Response> fetch3DResponse(
      String url, String d3Md, String d3Pareq) async {
    final response = await client
        .post(url,
            body: jsonEncode(<String, String>{
              'PaReq': d3Pareq,
              'MD': d3Md,
              'TermUrl': "www.example.com"
            }))
        .timeout(const Duration(seconds: 10))
        .catchError((e) {
      throw Exception('Failed to load post');
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
