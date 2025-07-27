import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/model/event.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:event/ui/home/tabs/home_tab/widgets/event_tab_item.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/app_style.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUset!.id);
    }

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.wlcome_back,
                  style: AppStyle.reguler14White,
                ),
                Text(
                  userProvider.currentUset!.name,
                  style: AppStyle.bold24White,
                ),
              ],
            ),
            Spacer(),
            ImageIcon(
              AssetImage(AppAssets.themeIcon),
              color: AppColors.whiteColor,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('EN', style: AppStyle.bold14Primary),
            ),
          ],
        ),
        bottom: AppBar(
          toolbarHeight: height * 0.1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.mapIcon),
                  SizedBox(width: width * 0.02),
                  Text('Cairo, Egypt', style: AppStyle.medium14White),
                ],
              ),
              SizedBox(height: height * 0.01),
              DefaultTabController(
                length: eventListProvider.eventNameList.length,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorColor: AppColors.transparentColor,
                  dividerColor: AppColors.transparentColor,
                  onTap: (index) {
                    eventListProvider.changeSelectedIndex(
                      index,
                      userProvider.currentUset!.id,
                    );
                  },
                  tabs:
                      eventListProvider.eventNameList.map((eventName) {
                        return EventTabItem(
                          selectedTextStyle:
                              Theme.of(context).textTheme.headlineMedium!,
                          unSelectedTextStyle:
                              Theme.of(context).textTheme.headlineSmall!,
                          selectedColor: Theme.of(context).focusColor,
                          isSelected:
                              eventListProvider.selectedIndex ==
                              eventListProvider.eventNameList.indexOf(
                                eventName,
                              ),
                          eventName: eventName,
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          children: [
            Expanded(
              child:
                  eventListProvider.filterEventsList.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(Animations.loadingAnimation),
                            Text(
                              '${AppLocalizations.of(context)!.no_event}..',
                              style: AppStyle.bold16Black,
                            ),
                          ],
                        ),
                      )
                      : StreamBuilder<QuerySnapshot>(
                        stream: usersStream,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView.separated(
                            padding: EdgeInsets.only(top: height * 0.02),
                            itemBuilder: (context, index) {
                              return EventItem(
                                event:
                                    eventListProvider.filterEventsList[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: height * 0.02);
                            },
                            itemCount:
                                eventListProvider.filterEventsList.length,
                          );
                        },
                      ),
            ),

            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
