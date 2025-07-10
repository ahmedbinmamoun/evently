import 'package:event/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:event/ui/home/tabs/home_tab/widgets/event_tab_item.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
      
    ];
    
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.wlcome_back,style: AppStyle.reguler14White,),
                Text('Route Accademy',style: AppStyle.bold24White,),
              ],
            ),
            Spacer(),
            ImageIcon(AssetImage(AppAssets.themeIcon),
            color: AppColors.whiteColor,
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.02,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),

              ),
              child: Text('EN',style: AppStyle.bold14Primary,),
            )
          ],
        ),
        bottom: AppBar(
          toolbarHeight: height * 0.1,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.mapIcon),
                  SizedBox(width: width * 0.02,),
                  Text('Cairo, Egypt',style: AppStyle.medium14White,),
                ],
              ),
              SizedBox(height: height * 0.01,),
              DefaultTabController(
                length: eventNameList.length,
               child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: AppColors.transparentColor,
                dividerColor: AppColors.transparentColor,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {
                    
                  });
                },
                tabs: eventNameList.map((eventName){
                  return EventTabItem(
                    isSelected: selectedIndex == eventNameList.indexOf(eventName),
                   eventName: eventName
                   );
                }).toList(),
                ),
               ),
            ],
          ),
        ),
      ),
    
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: Column(
          children: [
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
      ),
    );
  }
}