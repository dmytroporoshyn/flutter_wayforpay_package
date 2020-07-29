import 'package:flutter_wayforpay_package/model/verify_3ds_model.dart';
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

  Future<WayForPayResponse> verify3dsSecure(
      Verify3DsModel verify3dsModel) async {
    final response = await client
        .post("https://api.wayforpay.com/api",
            body: verify3DsModelToJson(verify3dsModel))
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
}
