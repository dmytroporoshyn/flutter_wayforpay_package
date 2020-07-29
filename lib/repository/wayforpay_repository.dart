import 'package:flutter_wayforpay_package/model/verify_3ds_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_wayforpay_package/provider/wayforpay_provider.dart';

class WayForPayRepository {
  final provider = WayforpayProvider();

  Future<WayForPayResponse> fetchWayForPayResponse(
          WayForPayModel wayForPayModel) =>
      provider.fetchWayForPayResponse(wayForPayModel);

  Future<WayForPayResponse> verify3dsSecure(Verify3DsModel verify3dsModel) =>
      provider.verify3dsSecure(verify3dsModel);
}
