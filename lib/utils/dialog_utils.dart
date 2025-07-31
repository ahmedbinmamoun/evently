import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogUtils {
  static void showDialgLoding({required BuildContext context}){
    showDialog(
      barrierDismissible: false,
      context: context,
       builder: (context) => AlertDialog(
        
        content: Row(
          children: [
            CircularProgressIndicator(
              color: AppColors.primaryLight,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            Text('${AppLocalizations.of(context)!.loading}..',style: AppStyle.medium16Black,)
          ],
        ),
       ),
       );
  }

  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? posActionsName,
    Function? posAction,
    String? negActionsName,
    Function? negAction,
    String? title,
    
    }){
      List<Widget> actions = [];
      if (posActionsName != null) {
        actions.add(
          TextButton(onPressed: (){
            Navigator.pop(context);
            posAction?.call();
          },
           child: Text(posActionsName,style: AppStyle.medium16Black,)
           )
        );
      }
      if (negActionsName != null) {
        actions.add(
          TextButton(onPressed: (){
            Navigator.pop(context);
            negAction?.call();
          },
           child: Text(negActionsName,style: AppStyle.medium16Black,)
           )
        );
      }
    showDialog(
      context: context,
     builder: (context) => AlertDialog(
      title: Text(title?? '' ,style: AppStyle.medium16Black,),
      content: Text(message,style: AppStyle.medium16Black,),
      actions: actions,
     ),
     );
  }

}