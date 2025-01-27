import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlashbar extends StatelessWidget {
  const CustomFlashbar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      borderRadius: BorderRadius.circular(5),
      duration: Duration(seconds: 2),
      messageText: Text('لطفا تمامی فیلد ها را پر کنید !', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.white)),
      icon: Icon(Icons.info_outline, size: 28.0, color: Colors.white),
      shouldIconPulse: false,
    )..show(context);
  }
}
