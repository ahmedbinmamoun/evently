import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';

class AddDateOrTimeWidget extends StatelessWidget {
  String dateOrTimeEventText;
  String chooseDateOrTime;
  String icon;
  VoidCallback onChooseDateOrTimeClick;

   AddDateOrTimeWidget({
    super.key,
    required this.dateOrTimeEventText,
    required this.chooseDateOrTime,
    required this.icon,
    required this.onChooseDateOrTimeClick,
   });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return  Row(
                children: [
                  Image.asset(icon,color: Theme.of(context).hintColor,),
                  SizedBox(width: width * 0.02,),
                  Text(dateOrTimeEventText,style: Theme.of(context).textTheme.titleMedium,),
                  Spacer(),
                  TextButton(
                    onPressed: onChooseDateOrTimeClick,
                    child: Text(chooseDateOrTime,style: AppStyle.medium16Primary,)),
                ],
              );
              
  }
}