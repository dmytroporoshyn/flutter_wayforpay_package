import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wayforpay_package/customView/my_text_field.dart';
import 'package:flutter_wayforpay_package/customView/sq_date_picker.dart';
import 'package:flutter_wayforpay_package/model/card_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_wayforpay_package/utils/types.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'flutter_wayforpay_package.dart';


class CardEnterScreen extends StatefulWidget {
  final WayForPay wayForPay;
  final dynamic amount;
  final String currencyType;
  final String merchantTransactionSecureType;
  final String orderReference;
  final DateTime orderDate;

  const CardEnterScreen(
      {Key key,
      @required this.wayForPay,
      @required this.amount,
      @required this.currencyType,
      @required this.merchantTransactionSecureType,
      @required this.orderReference,
      @required this.orderDate})
      : super(key: key);

  @override
  _CardEnterScreenState createState() => _CardEnterScreenState();
}

class _CardEnterScreenState extends State<CardEnterScreen> {
  var cardNumberFormatter = new MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
  var cvvFormatter =
      new MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardExpiredController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  FocusNode cardNumberFocusNode = FocusNode();
  FocusNode cardHolderFocusNode = FocusNode();
  FocusNode cvvFocusNode = FocusNode();

  bool obscureText = true;
  bool isLoading = false;
  int indexStack = 0;
  String errorText = "";
  DateTime cardExpired = DateTime.now();
  WayForPayResponse _wayForPayResponse;

  void formatDate(DateTime value) {
    cardExpired = value;
    String cardExpiredString = cardExpired.month.toString().padLeft(2, "0") +
        "/" +
        cardExpired.year.toString().substring(2);
    cardExpiredController.text = cardExpiredString;
  }

  void showDatePicker() {
    CardDatePicker(context,
            date: cardExpired,
            onDateTimeChanged: formatDate,
            onDateTimeDone: formatDate)
        .show();
  }

  void showCvv() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void startPayment() {
    setState(() {
      indexStack = 1;
    });
    CardModel cardModel = CardModel(
        card: cardNumberController.text.replaceAll(" ", ""),
        cardCvv: cvvController.text,
        cardHolder: cardHolderController.text,
        expMonth: cardExpired.month.toString().padLeft(2, "0"),
        expYear: cardExpired.year.toString());
    widget.wayForPay
        .makePayment(context,
            cardModel: cardModel,
            amount: widget.amount,
            orderReference: widget.orderReference,
            currencyType: widget.currencyType,
            merchantTransactionSecureType: widget.merchantTransactionSecureType,
            orderDate: widget.orderDate)
        .then((wayForPayResponse) {
      _wayForPayResponse = wayForPayResponse;
      switch (wayForPayResponse.transactionStatus) {
        case TransactionStatus.Approved:
          setState(() {
            indexStack = 2;
          });
          return wayForPayResponse;
          break;
        case TransactionStatus.InProcessing:
          setState(() {
            indexStack = 3;
            errorText = wayForPayResponse.transactionStatus +
                " " +
                wayForPayResponse.reasonCode.toString() +
                ": " +
                wayForPayResponse.reason;
          });
          return wayForPayResponse;
          break;
        case TransactionStatus.Declined:
          setState(() {
            indexStack = 3;
            errorText = wayForPayResponse.transactionStatus +
                " " +
                wayForPayResponse.reasonCode.toString() +
                ": " +
                wayForPayResponse.reason;
          });
          return wayForPayResponse;
          break;
        default:
          return wayForPayResponse;
          break;
      }
    });
  }

  void checkFields() {
    if (cardNumberController.text.isEmpty ||
        cardNumberController.text.length < 19) {
      cardNumberFocusNode.requestFocus();
      return;
    }
    if (cardHolderController.text.isEmpty) {
      cardHolderFocusNode.requestFocus();
      return;
    }
    if (cardExpiredController.text.isEmpty) {
      showDatePicker();
      return;
    }
    if (cvvController.text.isEmpty) {
      cvvFocusNode.requestFocus();
      return;
    }
    startPayment();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    cardExpiredController.dispose();
    cvvController.dispose();

    cardNumberFocusNode.dispose();
    cardHolderFocusNode.dispose();
    cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _wayForPayResponse);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Image.asset(
                        "assets/WayForPay_logo_black.png",
                        width: 280,
                        package: "flutter_wayforpay_package",
                      ),
                    ),
                    Container(
                      width: 360,
                      height: 250,
                      margin: EdgeInsets.all(16),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 4),
                              blurRadius: 8)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: IndexedStack(
                        index: indexStack,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MyTextField(
                                showSuffixButton: false,
                                hint: "0000 0000 0000 0000",
                                focusNode: cardNumberFocusNode,
                                controller: cardNumberController,
                                keyboardType: TextInputType.number,
                                title: "Card Number",
                                maxLength: 19,
                                inputFormatters: [cardNumberFormatter],
                              ),
                              MyTextField(
                                showSuffixButton: false,
                                title: "Card Holder",
                                focusNode: cardHolderFocusNode,
                                controller: cardHolderController,
                                keyboardType: TextInputType.text,
                                hint: "Ivanov Ivan",
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: CupertinoButton(
                                      onPressed: showDatePicker,
                                      padding: EdgeInsets.all(0),
                                      child: MyTextField(
                                        controller: cardExpiredController,
                                        showSuffixButton: true,
                                        title: "Expired",
                                        hint: "MM/YY",
                                        enable: false,
                                        textSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: MyTextField(
                                      showSuffixButton: true,
                                      suffixIcon: Icons.visibility,
                                      focusNode: cvvFocusNode,
                                      suffixColor: obscureText
                                          ? Colors.grey
                                          : Theme.of(context).accentColor,
                                      title: "CVV",
                                      controller: cvvController,
                                      hint: "111",
                                      inputFormatters: [cvvFormatter],
                                      keyboardType: TextInputType.number,
                                      onSuffixPress: showCvv,
                                      obscureText: obscureText,
                                      maxLength: 3,
                                      textSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Center(child: CircularProgressIndicator()),
                          Center(
                              child: Icon(
                            CupertinoIcons.check_mark_circled,

                            color: Colors.green,

                            size: 100,
                          )),
                          Center(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                CupertinoIcons.clear_circled,
                                color: Colors.red,
                                size: 100,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                errorText,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: indexStack != 1 ? 1.0 : 0.0,
                child: FlatButton(
                    onPressed: indexStack == 1
                        ? null
                        : () {
                            if (indexStack == 0) {
                              checkFields();
                            } else {
                              Navigator.of(context).pop(_wayForPayResponse);
                            }
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    color: Theme.of(context).accentColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        indexStack == 0 ? "Pay" : "Go back",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
