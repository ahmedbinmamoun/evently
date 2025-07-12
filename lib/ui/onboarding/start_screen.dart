import 'package:event/providers/app_language_provider.dart';
import 'package:event/providers/app_theme_provider.dart';
import 'package:event/ui/home/widgets/custom_elevated_button.dart';
import 'package:event/ui/onboarding/widgets/image_toggle_switch.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class StartScreen extends StatefulWidget {
  
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<StartScreen> {
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    bool isFirst = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: Image.asset(AppAssets.titleLogo),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03,),
              Center(child: Image.asset(AppAssets.beingCreative)),
              SizedBox(height: height * 0.04,),
              Text(AppLocalizations.of(context)!.personalize_ur_experience,style: AppStyle.bold20Primary,),
              SizedBox(height: height * 0.03,),
              Text(AppLocalizations.of(context)!.choose_ur_preferred_theme,style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.language,style: AppStyle.medium20Primary,),
                  ImageToggleSwitch(
                  firstAsset: AppAssets.usaFlag,
                  secondAsset: AppAssets.egyptFlag,
                  isFirstSelected: true,
                  onToggle: (isEnglish) {
                    isEnglish ? appLanguageProvider.changeLanguage('en') : appLanguageProvider.changeLanguage('ar') ;
                    
                    
                  },
                ),
                ],
              ),
               SizedBox(height: height * 0.02,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.theme,style: AppStyle.medium20Primary,),
                  ImageToggleSwitch(
                  firstAsset: AppAssets.lightIcon,
                  secondAsset: AppAssets.darkIcon,
                  isFirstSelected: !(appThemeProvider.isDarkMode()),
                  onToggle: (isFirst) {
                   isFirst ? appThemeProvider.changeTheme(ThemeMode.light) : appThemeProvider.changeTheme(ThemeMode.dark);
                  },
                ),
                ],
              ),
              SizedBox(height: height * 0.02,),

             CustomElevatedButton(onPressed: (){
              Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouteName);
             }, text: AppLocalizations.of(context)!.start),
            ],
          ),
        ),
      ),
    );
  }
}