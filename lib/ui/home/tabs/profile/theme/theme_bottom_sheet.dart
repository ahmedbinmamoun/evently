import 'package:event/providers/app_theme_provider.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
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
              appThemeProvider.changeTheme(ThemeMode.light);
            },
            child: !(appThemeProvider.isDarkMode()) ? getSelectedThemeItem(languageText: AppLocalizations.of(context)!.light)
            :getUnSelectedThemeItem(languageText: AppLocalizations.of(context)!.light)
          ),
          SizedBox(height: height * 0.02,),
          InkWell(
            onTap: (){
              appThemeProvider.changeTheme(ThemeMode.dark);
            },
            child: appThemeProvider.isDarkMode()? getSelectedThemeItem(languageText: AppLocalizations.of(context)!.dark)
            :getUnSelectedThemeItem(languageText: AppLocalizations.of(context)!.dark)),
        ],
      ),
    );
  }

  Widget getSelectedThemeItem({required String languageText}){
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(languageText,style: AppStyle.bold20Primary,),
                Icon(Icons.check,color: AppColors.primaryLight,size: 35,),
              ],
            );
  }

  Widget getUnSelectedThemeItem({required String languageText}){
    return Text(languageText,style: AppStyle.bold20Black,);
  }
}