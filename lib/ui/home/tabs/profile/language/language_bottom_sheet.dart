import 'package:event/providers/app_language_provider.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en' ? getSelectedLanguageItem(languageText: AppLocalizations.of(context)!.english)
            :getUnSelectedLanguageItem(languageText: AppLocalizations.of(context)!.english)
          ),
          SizedBox(height: height * 0.02,),
          InkWell(
            onTap: (){
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar' ? getSelectedLanguageItem(languageText: AppLocalizations.of(context)!.arabic)
            :getUnSelectedLanguageItem(languageText: AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String languageText}){
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(languageText,style: AppStyle.bold20Primary,),
                Icon(Icons.check,color: AppColors.primaryLight,size: 35,),
              ],
            );
  }

  Widget getUnSelectedLanguageItem({required String languageText}){
    return Text(languageText,style: AppStyle.bold20Black,);
  }
}