import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';


  typedef OnValidator = String? Function(String?)?;
class CustomTextFormFeild extends StatelessWidget {
  Color colorBorderSide;
  Color? cursorColor;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController controller;
  TextInputType keyboardType;
  OnValidator? validator;
  bool obscureText;
  String? obscureCharacter;
  TextStyle? textStyle;
  int? maxLine;
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
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.obscureCharacter,
    this.textStyle,
    this.maxLine
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle ?? AppStyle.medium16Grey.copyWith(color: Theme.of(context).hintColor),
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
        focusedBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
        errorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
        focusedErrorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyle.medium16Grey.copyWith(color: Theme.of(context).hintColor),
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyle.medium16Grey.copyWith(color: Theme.of(context).hintColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        
      ),
      cursorColor: cursorColor,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscureCharacter ?? '.',
      maxLines: maxLine ?? 1,
      
      
      
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