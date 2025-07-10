import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  Color colorBorderSide;
  Color? cursorColor;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
   CustomTextFormFeild({
    super.key,
    this.colorBorderSide = AppColors.greyColor,
    this.cursorColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
        focusedBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
        errorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
        focusedErrorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyle.medium16Grey,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyle.medium16Grey,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      cursorColor: cursorColor,
      
      
    );
  }
  OutlineInputBorder builtDecorationBorder({required Color colorBorderSide}){
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorBorderSide,
            width: 1,
          ),
        );
  }
}