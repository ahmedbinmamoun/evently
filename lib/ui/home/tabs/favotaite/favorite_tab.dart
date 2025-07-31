import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:event/ui/home/widgets/custom_text_form_feild.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventListProvider.getAllFavoriteEventFromFirsStore(
        userProvider.currentUset!.id,
      );
    });
    searchController.addListener(() {
      eventListProvider.searchFavoriteEvents(searchController.text);
    },);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            CustomTextFormFeild(
              onChange: (searchText) {
                eventListProvider.searchFavoriteEvents(searchText);
              },
              controller: searchController,
              colorBorderSide: AppColors.primaryLight,
              cursorColor: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyle.bold14Primary,
              prefixIcon: Image.asset(AppAssets.searchIcon),
            ),
            Expanded(
              child:
                  eventListProvider.searchedFavoriteList.isEmpty
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
                      : ListView.separated(
                        padding: EdgeInsets.only(top: height * 0.02),
                        itemBuilder: (context, index) {
                          return EventItem(
                            event: eventListProvider.searchedFavoriteList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: height * 0.02);
                        },
                        itemCount: eventListProvider.searchedFavoriteList.length,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
