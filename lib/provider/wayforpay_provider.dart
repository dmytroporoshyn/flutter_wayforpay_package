import 'package:flutter_wayforpay_package/model/verify_3ds_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_wayforpay_package/utils/types.dart';
import 'package:http/http.dart';

class WayforpayProvider {
  /// Client
  Client client = Client();

  /// Charge request is used for quick payment making in one action. It is performed within the limits of single-staged pattern.
  ///
  /// The result of request processing is the withdrawal of monetary assets from client’s card.
  /// For more info, please visit https://wiki.wayforpay.com/pages/viewpage.action?pageId=1736987
  /// [wayForPayModel] WayForPayModel
  Future<WayForPayResponse> fetchWayForPayResponse(
      WayForPayModel wayForPayModel) async {
    final response = await client
        .post(Uri.parse("https://api.wayforpay.com/api"),
            body: wayForPayModelToJson(wayForPayModel))
        .timeout(const Duration(seconds: 10))
        .catchError((e) {
      throw Exception('Failed to load post');
    });
    if (response.statusCode == 200) {
      return wayForPayResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  /// In case of  [MerchantTransactionSecureType.AUTO], there is initially performed the checking of the card for participation in 3d secure program.
  /// If the card does not supports 3D Secure  - there will be returned the response  Declined, code 1120, description Authentication unavailable.
  /// If the card supports 3D Secure  verification the system Wayforpay will return the parameters for authentication of the client.
  ///
  /// For more info, please visit https://wiki.wayforpay.com/pages/viewpage.action?pageId=1736987
  /// [verify3dsModel] Verify3DsModel
  Future<WayForPayResponse> verify3dsSecure(
      Verify3DsModel verify3dsModel) async {
    final response = await client
        .post(Uri.parse("https://api.wayforpay.com/api"),
            body: verify3DsModelToJson(verify3dsModel))
        .timeout(const Duration(seconds: 10))
        .catchError((e) {
      throw Exception('Failed to load post');
    });
    if (response.statusCode == 200) {
      return wayForPayResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
