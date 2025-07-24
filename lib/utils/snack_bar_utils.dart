import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackBarUtils {

  static void showSnackBar({required BuildContext context,required String text}){
        
       return showTopSnackBar(
                Overlay.of(context),
                snackBarPosition: SnackBarPosition.bottom,
                CustomSnackBar.success(
                  message:
                      text,
    ),
);
                                

                                
  }
}