import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wayforpay_package/model/pares_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VerificationScreen extends StatefulWidget {
  final WayForPayResponse url;

  const VerificationScreen({Key key, this.url}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  static const String POST_BACK_URL =
      "https://demo.cloudpayments.ru/WebFormPost/GetWebViewData";

  String url;

  String buildUrl() {
    return '''<form name="downloadForm" action="${widget.url.d3AcsUrl}" method="POST">
  <input type="hidden" name="PaReq" value="${widget.url.d3Pareq}">
  <input type="hidden" name="MD" value="${widget.url.d3Pareq}">
  <input type="hidden" name="TermUrl" value="$POST_BACK_URL">
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

    flutterWebViewPlugin.onUrlChanged.listen((event) {
      print(event);
      if (event.toLowerCase().contains(POST_BACK_URL.toLowerCase())) {
        flutterWebViewPlugin
            .evalJavascript(
                "window.document.getElementsByTagName('body')[0].innerHTML;")
            .then((value) {
          String response = value.replaceAll(r"\n", "");
          response = response.replaceAll(" ", "");
          response = response.replaceAll(r"\", "");
          response = response.substring(1, response.length - 1);
          PaResModel paResModel = paResModelFromJson(response);
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
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
