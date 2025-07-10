import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

PageViewModel onboardingPage3(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
  return PageViewModel(

   
  title: "", 
  bodyWidget: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: height * 0.4,
        width: double.infinity,
        child: Image.asset(
          AppAssets.socialMedia,
          fit: BoxFit.contain,
        ),
      ),
       SizedBox(height: height * 0.05),
      Text(
        AppLocalizations.of(context)!.connect_with_frinds,
            style: AppStyle.bold20Primary,
      ),
       SizedBox(height: height * 0.02),
      Text(AppLocalizations.of(context)!.make_every_event_memorable,
      style: Theme.of(context).textTheme.bodyMedium,
      ),
    ],
  ),
  decoration: PageDecoration(
    contentMargin: EdgeInsets.symmetric(horizontal: 16),
    imageFlex: 0, 
    bodyFlex: 1,
  ),
);
}
    
   