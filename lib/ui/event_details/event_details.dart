import 'package:event/model/event.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/home/widgets/custom_elevated_button.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/app_style.dart';
import 'package:event/utils/dialog_utils.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late Event event;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    event = ModalRoute.of(context)?.settings.arguments as Event;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details', style: AppStyle.medium20Primary),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              final updateEvent =
                  await Navigator.pushNamed(
                        context,
                        AppRoutes.editEvent,
                        arguments: event,
                      )
                      as Event?;
              if (updateEvent != null) {
                event = updateEvent;
                setState(() {});
              }
            },
            child: Image.asset(AppAssets.edit),
          ),

          SizedBox(width: width * 0.02),

          InkWell(
            onTap: () {
              var userProvider = Provider.of<UserProvider>(
                context,
                listen: false,
              );
              DialogUtils.showMessage(
                context: context,
                message: 'Are you sure',
                posActionsName: 'Yes',
                posAction: () async {
                  await FirebaseUtils.getEventCollection(
                    userProvider.currentUset!.id,
                  ).doc(event.id).delete();
                  eventListProvider.getAllEvents(userProvider.currentUset!.id);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.homeRouteName,
                    (route) => false,
                  );
                },
                negActionsName: 'No',
                title: 'Delete',
              );
            },
            child: Image.asset(AppAssets.deleteIcon),
          ),

          SizedBox(width: width * 0.02),
        ],
        backgroundColor: AppColors.transparentColor,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(event.eventImage),
              ),
              SizedBox(height: height * 0.015),
              Center(child: Text(event.title, style: AppStyle.medium24Primary)),
              SizedBox(height: height * 0.015),
              CustomElevatedButton(
                onPressed: () {},
                hasIcon: true,
                backgroundColor: AppColors.transparentColor,
                borderColorSide: AppColors.primaryLight,
                verticalPadding: 0.011,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight,
                      ),
                      child: Image.asset(
                        AppAssets.calenderIcon,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(event.eventDateTime),
                          style: AppStyle.medium16Primary,
                        ),
                        Text(event.eventTime, style: AppStyle.medium16Black),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.015),
              CustomElevatedButton(
                onPressed: () {},
                hasIcon: true,
                backgroundColor: AppColors.transparentColor,
                borderColorSide: AppColors.primaryLight,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight,
                      ),
                      child: Image.asset(AppAssets.locationIcon),
                    ),
                    Text('Cairo, Egypt', style: AppStyle.medium16Primary),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryLight,
                    ),
                    SizedBox(width: width * 0.02),
                  ],
                ),
              ),
              SizedBox(height: height * 0.015),
              Container(
                width: width,
                height: height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: AppColors.primaryLight),
                ),
                child: Image.asset(AppAssets.locationImage, fit: BoxFit.fill),
              ),
              SizedBox(height: height * 0.015),
              Text('Description', style: AppStyle.medium16Black),
              SizedBox(height: height * 0.01),
              Text(event.description, style: AppStyle.medium16Black),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
