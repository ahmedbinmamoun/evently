import 'package:event/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:event/ui/home/widgets/custom_text_form_feild.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteTab extends StatelessWidget {
   FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02
        ),
        child: Column(
        children: [
          SizedBox(height: height * 0.02,),
          CustomTextFormFeild(
            colorBorderSide: AppColors.primaryLight,
            cursorColor: AppColors.primaryLight,
            hintText: AppLocalizations.of(context)!.search_event,
            hintStyle: AppStyle.bold14Primary,
            prefixIcon: Image.asset(AppAssets.searchIcon),
          ),
            Expanded(
                child: ListView.separated(
                padding: EdgeInsets.only(top: height * 0.02),
                itemBuilder: (context, index) {
                return EventItem();
                },
               separatorBuilder: (context, index) {
                 return SizedBox(height: height * 0.02,);
                 },
                itemCount: 20),
                ),
          
        ],
            ),
      ));
  }
}