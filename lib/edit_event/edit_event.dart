import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/app_theme_provider.dart';
import '../providers/event_list_provider.dart';
import '../providers/user_provider.dart';
import '../ui/add_event/widgets/event_date_or_time.dart';
import '../ui/home_tab/widget/event_tab_item.dart';
import '../ui/widgets/custom_elevated_button.dart';
import '../utils/app_colors.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late Event event;
  bool isInitialized = false;
  late TextEditingController titleController;

  late TextEditingController descriptionController;

  late DateTime dateTime;

  late String time;
  late int selectedIndex;

  DateTime? selectedDate;
  String? formatDate;
  TimeOfDay? selectedTime;
  String? formatTime;
  String? selectedEventName;
  String? selectedEventImage;
  List<String> eventNameList = [];
  List<String> eventImageLightList = [];
  List<String> eventImageDarkList = [];

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      event = ModalRoute
          .of(context)!
          .settings
          .arguments as Event;
      eventNameList = [
        AppLocalizations.of(context)!.sport,
        AppLocalizations.of(context)!.birthday,
        AppLocalizations.of(context)!.meeting,
        AppLocalizations.of(context)!.gaming,
        AppLocalizations.of(context)!.workshop,
        AppLocalizations.of(context)!.book_club,
        AppLocalizations.of(context)!.exhibition,
        AppLocalizations.of(context)!.holiday,
        AppLocalizations.of(context)!.eating,
      ];
      eventImageLightList = [
        AppAssets.sportImageLight,
        AppAssets.birthdayImageLight,
        AppAssets.meetingImageLight,
        AppAssets.gammingImageLight,
        AppAssets.workShopImageLight,
        AppAssets.bookClubImageLight,
        AppAssets.exhibitionImageLight,
        AppAssets.holidayImageLight,
        AppAssets.eatingImageLight,
      ];
      List<String> eventImageDarkList = [
        AppAssets.sportImageDark,
        AppAssets.birthdayImageDark,
        AppAssets.meetingImageDark,
        AppAssets.gammingImageDark,
        AppAssets.workShopImageDark,
        AppAssets.bookClubImageDark,
        AppAssets.exhibitionImageDark,
        AppAssets.holidayImageDark,
        AppAssets.eatingImageDark,
      ];
      titleController = TextEditingController(text: event.title);
      descriptionController = TextEditingController(text: event.description);
      dateTime = event.dateTime;
      time = event.time;
      selectedIndex = eventNameList.indexOf(event.eventName);
      if (selectedIndex == -1) {
        selectedIndex = 0;
      }
      selectedEventName = eventNameList[selectedIndex];
      selectedEventImage = eventImageLightList[selectedIndex];
      isInitialized = true;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event', style: AppStyles.medium20Primary),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  child: Image.asset(
                    selectedEventImage ?? event.image,
                    height: height * .2,
                  ),
                  borderRadius: BorderRadius.circular(16),


                ),
              ),
              SizedBox(height: height * .02),
              SizedBox(
                height: height * .04,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        selectedEventName = eventNameList[index];
                        selectedEventImage = eventImageLightList[index];
                        setState(() {});
                      },
                      child: EventTabItem(
                        isSelectedBgColor: AppColors.primaryLight,
                        selecetdEventTextStyle: Theme.of(
                          context,
                        ).textTheme.labelMedium,
                        eventName: eventNameList[index],
                        unSelecetdEventTextStyle: AppStyles.bold16Primary,
                        borderColor: AppColors.primaryLight,
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * .01);
                  },
                  itemCount: eventNameList.length,
                ),
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              SizedBox(height: height * .01),
              CustomTextFormField(
                hintText: '',
                controller: titleController,
                textStyle: AppStyles.medium16Grey,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.editIcon),
                  color: AppColors.greyColor,
                ),
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              SizedBox(height: height * .01),
              CustomTextFormField(
                hintText: '',
                controller: descriptionController,
                textStyle: AppStyles.medium16Grey,
              ),
              SizedBox(height: height * .02),
              EventDateOrTime(
                eventDateOrItemIcon: AppAssets.eventDateIcon,
                eventDateOrItemName: AppLocalizations.of(context)!.event_date,
                chooseDateOrTime: DateFormat('dd/MM/yyyy').format(
                    selectedDate ?? event.dateTime),

                chooseDateOrTimeClicked: ChooseDate,
              ),
              EventDateOrTime(
                eventDateOrItemIcon: AppAssets.eventTimeIcon,
                eventDateOrItemName: AppLocalizations.of(context)!.event_time,
                chooseDateOrTime: formatTime ?? event.time,
                chooseDateOrTimeClicked: ChooseTime,
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.location,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              SizedBox(height: height * .01),
              CustomElevatedButton(
                backgroundColor: AppColors.transparentColor,
                text: '',
                isIcon: true,
                iconWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .02),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .02,
                          vertical: height * .01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight,
                        ),
                        child: Image.asset(AppAssets.locationIcon),
                      ),
                      SizedBox(width: width * .02),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: AppStyles.medium16Primary,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.primaryLight,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: 'Update Event',
                  onPressed: () {
                    // eventListProvider.editEvent(E);
                    updateEvent();
                    print('event title ${event.title}');
                    print('event desc ${event.description}');
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: height * .02),
            ],
          ),
        ),
      ),
    );
  }

  void ChooseDate() async {
    var chooseDate = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void ChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatTime = selectedTime!.format(context);
    setState(() {});
  }

  void updateEvent() {
    final newEvent = Event(
      id: event.id,
      title: titleController.text,
      description: descriptionController.text,
      image: selectedEventImage ?? event.image,
      eventName: selectedEventName ?? '',
      dateTime: selectedDate ?? event.dateTime,
      time: formatTime ?? event.time,
    );
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    Provider.of<EventListProvider>(context, listen: false).editEvent(
        newEvent, userProvider.currentUser!.id);
    Provider.of<EventListProvider>(context, listen: false).getAllEvents(
        userProvider.currentUser!.id);
    Navigator.pop(context);
  }

}
