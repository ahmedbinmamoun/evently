import 'package:event/model/event.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/ui/home/add_event/widgets/add_date_or_time_widget.dart';
import 'package:event/ui/home/tabs/home_tab/widgets/event_tab_item.dart';
import 'package:event/ui/home/widgets/custom_elevated_button.dart';
import 'package:event/ui/home/widgets/custom_text_form_feild.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/app_style.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:event/utils/snack_bar_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
   AddEvent({super.key});


  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
   int selectedIndex = 0;
   String selectedEventImage = '';
   String selectedEventName = '';
   TextEditingController titleController = TextEditingController();
   TextEditingController descriptionController = TextEditingController();
   var formKey = GlobalKey<FormState>();
   DateTime? selectedDate;
   String formatedDate = '';
   String formatedTime = '';
   TimeOfDay? selectedTime;
   bool showDateError = false;
   bool showTimeError = false;
   late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
     eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventNameList = [
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
    List<String> lightEventImagesList = [
      AppAssets.sportImage,
      AppAssets.birthdayImage,
      AppAssets.meetingImage,
      AppAssets.gamingImage,
      AppAssets.workshopImage,
      AppAssets.bookClubImage,
      AppAssets.exhibitionImage,
      AppAssets.holidayImage,
      AppAssets.etingImage,
    ];
    selectedEventImage = lightEventImagesList[selectedIndex];
    selectedEventName = eventNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_event,style: AppStyle.medium20Primary),
         centerTitle: true,
         backgroundColor: AppColors.transparentColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  selectedEventImage,
                  ),
              ),
              SizedBox(height: height * 0.015,),
              SizedBox(height: height * 0.04,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder:(context, index) {
                  return  InkWell(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {
                        
                      });
                    },
                    child: EventTabItem(
                      selectedTextStyle: AppStyle.medium16Black.copyWith(
                        color: Theme.of(context).shadowColor
                      ),
                      unSelectedTextStyle: AppStyle.medium16Primary,
                      selectedColor: AppColors.primaryLight,
                      borderSideColor: AppColors.primaryLight,
                    isSelected: selectedIndex == index,
                     eventName: eventNameList[index]),
                  );
                },
               separatorBuilder: (context, index) {
                 return SizedBox(width: width * 0.02,);
               },
                itemCount: eventNameList.length),
              ),
              SizedBox(height: height * 0.01,),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.title,style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: height * 0.005,),
              CustomTextFormFeild(
                controller: titleController,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return AppLocalizations.of(context)!.plaese_enter_event_title;
                  }
                  return null;
                },
                prefixIcon: Image.asset(AppAssets.editIcon,color: Theme.of(context).hintColor,),
                hintText: AppLocalizations.of(context)!.event_title,
                colorBorderSide: Theme.of(context).cardColor,
              ),
              SizedBox(height: height * 0.01,),
              Text(AppLocalizations.of(context)!.description,style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: height * 0.005,),
              CustomTextFormFeild(
                controller: descriptionController,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return AppLocalizations.of(context)!.plaese_enter_event_description;
                  }
                  return null;
                },
                hintText: AppLocalizations.of(context)!.event_description,
                colorBorderSide: Theme.of(context).cardColor,
                maxLine: 4,
              ),
              SizedBox(height: height * 0.01,),
              SizedBox(
                height: height * 0.04,
                child: AddDateOrTimeWidget(
                  onChooseDateOrTimeClick: chooseDate,
                  icon: AppAssets.calenderIcon,
                  dateOrTimeEventText: 
                   AppLocalizations.of(context)!.event_date,
                   chooseDateOrTime:selectedDate == null ?
                    AppLocalizations.of(context)!.choose_date
                    :
                    formatedDate,
                   ),
              ),
              Visibility(
                visible: showDateError,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(AppLocalizations.of(context)!.plaese_enter_date,style: AppStyle.medium14White.copyWith(
                      color: AppColors.redColor,
                    ),)
                  ],
                ),
                ),
              // SizedBox(height: height * 0.015,),
              SizedBox(
                height: height * 0.04,
                child: AddDateOrTimeWidget(
                  onChooseDateOrTimeClick: chooseTime,
                  icon: AppAssets.clockIcon,
                  dateOrTimeEventText: AppLocalizations.of(context)!.event_time,
                   chooseDateOrTime:  selectedTime == null ?
                   AppLocalizations.of(context)!.choose_time
                   :
                   formatedTime,
                   ),
              ),
              Visibility(
                visible: showTimeError,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(AppLocalizations.of(context)!.plaese_enter_time,style: AppStyle.medium14White.copyWith(
                      color: AppColors.redColor,
                    ),)
                  ],
                ),
                ),
             SizedBox(height: height * 0.01,),
              Text(AppLocalizations.of(context)!.location,style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: height * 0.01,),
              CustomElevatedButton(
                onPressed: (){
          
                },
                hasIcon: true,
                backgroundColor: AppColors.transparentColor,
                borderColorSide: AppColors.primaryLight,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width * 0.02
                      ),
                      padding: EdgeInsets.all(10),                    
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight,
                      ),
                      child: Image.asset(AppAssets.locationIcon),
                    ),
                    Text(AppLocalizations.of(context)!.choose_event_location,style: AppStyle.medium16Primary,),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,color: AppColors.primaryLight,),
                    SizedBox(width: width * 0.02,),
          
                  ],
                ),
                ),
                SizedBox(height: height * 0.015,),
                CustomElevatedButton(
                  onPressed: (){
                    addEvent();
                  },
                text: AppLocalizations.of(context)!.add_event,
                ),

                  ],
                )),
              
            ],
          ),
        ),
        ),
       
      );
    
  }

  
void chooseDate() async {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  var chooseDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: AppColors.whiteColor,
                  onSurface: AppColors.blackColor,
                  
                ),
          dialogBackgroundColor: Theme.of(context).primaryColor,
        ),
        child: child!,
      );
    },
  );

  if (chooseDate != null) {
    selectedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }
}


 void chooseTime() async {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  var chooseTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme:  ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: AppColors.whiteColor,
                  onSurface: AppColors.primaryLight,
                  background: AppColors.primaryDark
                  
                ),
          dialogBackgroundColor: Theme.of(context).primaryColor,
        ),
        child: child!,
      );
    },
  );

  if (chooseTime != null) {
    selectedTime = chooseTime;
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, selectedTime!.hour, selectedTime!.minute);
    formatedTime = DateFormat('hh:mm a').format(dateTime);
    setState(() {});
  }
}


  void addEvent(){
            setState(() {
              showDateError = selectedDate == null;
              showTimeError = selectedTime == null;
              if(formKey.currentState?.validate() == true){
                  if (!showDateError && !showTimeError) {
                          Event event = Event(
                            eventImage: selectedEventImage,
                            eventName: selectedEventName,
                              title: titleController.text,
                              description: descriptionController.text,
                                eventDateTime: selectedDate!,
                                eventTime: formatedTime
                                );
                          FirebaseUtils.addEventToFireStore(event).timeout(Duration(milliseconds: 500),
                          onTimeout: () {
                            // Toastutils.toastMsg(
                            //   msg: AppLocalizations.of(context)!.event_added_seccesffuly,
                            //   backgroundColor: AppColors.primaryLight);
                               
                               SnackBarUtils.showSnackBar(
                                context: context,
                                text: AppLocalizations.of(context)!.event_added_seccesffuly);
                            
                               
                                eventListProvider.getAllEvents();
                                Navigator.pop(context);
                          },
                          );
                       }
              }
              
            });
          
        }
}