import 'package:event/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toastutils {
  static Future<bool?> toastMsg({
    required String msg,
    required Color backgroundColor,
    Color? textColor,
  }){
    return Fluttertoast.showToast(
                                msg: msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: backgroundColor,
                                textColor: textColor ?? AppColors.whiteColor,
                                fontSize: 16.0
                            );
  }
}