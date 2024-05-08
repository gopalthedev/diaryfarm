import 'dart:ui';

import 'package:flutter/material.dart';

final TextStyle headerTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);
final Color appBarColor = Colors.green;

PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
    title: Text(title),
    backgroundColor: appBarColor,
    titleTextStyle: headerTextStyle,
    elevation: 5,
    clipBehavior: Clip.antiAlias,
    bottomOpacity: 0.1,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
    ),
  );
}

void showSnack(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      elevation: 5,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Container wideButton({ required String buttonName, required Function callBack}){
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.amber.shade200,
    ),
    child: MaterialButton(onPressed: (){
      callBack;
    },
      child: Text(buttonName),
    ),
  );
}
