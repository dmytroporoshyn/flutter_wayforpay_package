import 'package:flutter_wayforpay_package/model/wayforpay_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_wayforpay_package/provider/wayforpay_provider.dart';
import 'package:http/http.dart';

class WayForPayRepository {
  final provider = WayforpayProvider();

  Future<WayForPayResponse> fetchWayForPayResponse(
          WayForPayModel wayForPayModel) =>
      provider.fetchWayForPayResponse(wayForPayModel);

  Future<Response> fetch3DResponse(
      String url, String d3Md, String d3Pareq) =>
      provider.fetch3DResponse(url, d3Md, d3Pareq);
}
