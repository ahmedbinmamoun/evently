import 'package:event/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  bool isSelected;
  String eventName;   
  String eventIcon;   
  Color selectedColor;
  Color selectedIconColor;
  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;
  Color? borderSideColor;
   EventTabItem({
    required this.isSelected,
    required this.eventName,
    required this.eventIcon,
    required this.selectedColor,
     this.selectedIconColor = AppColors.primaryLight,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.borderSideColor,
     super.key});
  

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.002,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: borderSideColor ?? Theme.of(context).focusColor,
          width: 2
        ),
        color: isSelected ? selectedColor : AppColors.transparentColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Image.asset(eventIcon,height: height * 0.03,color: isSelected ? selectedIconColor : selectedColor,),
          ),
          SizedBox(width: width * 0.01,),
          Text(eventName,
          style: isSelected ? selectedTextStyle : unSelectedTextStyle,
          ),
        ],
      ),
    );
  }
}