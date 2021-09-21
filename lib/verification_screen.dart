import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wayforpay_package/model/pares_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VerificationScreen extends StatefulWidget {
  final WayForPayResponse? wayForPayResponse;

  const VerificationScreen({Key? key, this.wayForPayResponse})
      : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  static const String POST_BACK_URL =
      'https://demo.cloudpayments.ru/WebFormPost/GetWebViewData';

  late String url;

  String buildUrl() {
    return '''<form name='downloadForm' action='${widget.wayForPayResponse!.d3AcsUrl}' method='POST'>
  <input type='hidden' name='PaReq' value='${widget.wayForPayResponse!.d3Pareq}'>
  <input type='hidden' name='MD' value='${widget.wayForPayResponse!.d3Pareq}'>
  <input type='hidden' name='TermUrl' value='$POST_BACK_URL'>
  </form>
  <script>
  window.onload = submitForm;
  function submitForm() { downloadForm.submit(); }
  </script>''';
  }

  @override
  void initState() {
    super.initState();

    url = buildUrl();

    flutterWebViewPlugin.onUrlChanged.listen((url) {
      if (url.startsWith('http') &&
          url.toLowerCase().contains(POST_BACK_URL.toLowerCase())) {
        flutterWebViewPlugin
            .evalJavascript(
                'window.document.getElementsByTagName(\'body\')[0].innerHTML;')
            .then((value) {
          var response = value!.replaceAll(r'\n', '');
          response = response.replaceAll(' ', '');
          response = response.replaceAll(r'\', '');
          response = response.substring(1, response.length - 1);
          var paResModel = paResModelFromJson(response);
          Navigator.of(context).pop(paResModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: Uri.dataFromString(url, mimeType: 'text/html').toString(),
      initialChild: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
