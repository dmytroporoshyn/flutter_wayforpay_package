import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final IconData suffixIcon;
  final bool showSuffixButton;
  final String hint;
  final bool obscureText;
  final Color suffixColor;
  final String numberText;
  final String title;
  final bool enable;
  final double textSize;
  final int maxLength;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  final VoidCallback onSuffixPress;

  const MyTextField({
    Key key,
    this.suffixIcon = Icons.arrow_drop_down,
    this.showSuffixButton = true,
    this.hint = "",
    this.onSuffixPress,
    this.obscureText = false,
    this.numberText = "",
    this.suffixColor,
    this.title = "Card Number",
    this.textSize = 26,
    this.maxLength = 256,
    this.inputFormatters,
    this.enable = true,
    this.keyboardType,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
//        color: Colors.white,
//        border: Border.all(color: Color(0xFFCFD9E0), width: 0.5),
//        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 9, top: 8),
            child: Text(title,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).accentColor,
                )),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextField(
                      cursorWidth: 2,
                      focusNode: focusNode,
                      enabled: enable,
                      controller: controller,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      maxLength: maxLength,
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      maxLengthEnforced: true,
                      obscureText: obscureText,
                      style: TextStyle(
                          fontSize: textSize, color: Color(0xFF414256)),
                      cursorRadius: Radius.circular(2),
                      decoration: InputDecoration.collapsed(
                        hintText: hint,
                        hintStyle: TextStyle(
                            color: Color(0xFF9ea5ab), fontSize: textSize),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showSuffixButton,
                    child: CupertinoButton(
                      onPressed: onSuffixPress,
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      minSize: 10,
                      child: Icon(
                        suffixIcon,
                        color: suffixColor,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
