import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 사용법 : 원하는 텍스트만 사용하여 팝업을 생성하시면 됩니다^^
// showDialog (
// context : context,
// builder : (context) {
//  return CustomAlertDialog.build(context: context, title : '여기다가 제목^^', text : '여기다가 이쁜 말 써주세요^^');
// }

class CustomAlertDialog {
  static Widget build(
      {required BuildContext context, required String title, required text}) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Dovemayo_gothic',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        softWrap: true,
        style: TextStyle(
          fontFamily: 'Dovemayo_gothic',
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              '확인',
              style: TextStyle(
                fontFamily: 'Dovemayo_gothic',
                fontSize: 12,
              ),
            )),
      ],
    );
  }
}
