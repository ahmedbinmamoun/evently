import 'package:event/model/event.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  Event event;
   EventItem({super.key,required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.eventDetails,arguments: event);
      },
      child: Container(
        height: height * 0.31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryLight,
            width: 2,
          ),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(event.eventImage))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.001,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    event.eventDateTime.day.toString(),
                  style: AppStyle.bold20Primary,
                  ),
                  Text(
                    DateFormat('MMM').format(event.eventDateTime),
                    style: AppStyle.bold14Primary,
                    ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                    event.title,
                  style: AppStyle.bold14Black,
                    )),
                  InkWell(
                    onTap: (){
                          eventListProvider.updateIsFavorite(event);
                    },
                    child:event.isFavorite == true ?
                    Image.asset(AppAssets.selectedFavoriteIcon,color: AppColors.primaryLight,)
                    :
                     Image.asset(AppAssets.favoriteIcon,color: AppColors.primaryLight,),
                     ),
                ],
              ),
            )
         
          ],
        ),
      ),
    );
  }
}