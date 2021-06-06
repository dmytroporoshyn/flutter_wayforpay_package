/*
 * Copyright (c) 2020.  Dmytro Poroshyn
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wayforpay_package/customView/date_picker.dart';

///[SqPicker] for get user birthday
class CardDatePicker {
  ///[context]
  BuildContext context;
  DateTime? date = DateTime.now();

  ///On Date Time Changed
  final ValueChanged<DateTime> onDateTimeChanged;
  final ValueChanged<DateTime?>? onDateTimeDone;

  final TextStyle buttonTextStyle;
  final Color backgroundColor;
  final String buttonText;

  final FixedExtentScrollController? controller;

  ///Constructor [SqPicker]
  ///[onPickerChanged] is required
  CardDatePicker(
    this.context, {
    this.date,
    this.controller,
    this.buttonText = "Choose",
    this.backgroundColor = const Color.fromRGBO(115, 3, 226, 0.05),
    this.buttonTextStyle = const TextStyle(),
    required this.onDateTimeChanged,
    this.onDateTimeDone,
  });

  //Show modal popup
  void show() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CupertinoButton(
                      child: Text(
                        buttonText,
                        style: buttonTextStyle,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onDateTimeDone!(date);
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: MyDatePicker(
                  mode: MyDatePickerMode.yearAndMonth,
                  onDateTimeChanged: (date) {
                    this.date = date;
                    onDateTimeChanged(date);
                  },
                  minimumDate: DateTime.now(),
                  initialDateTime: date,
                )),
              ],
            ),
          );
        });
  }
}
