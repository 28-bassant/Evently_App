import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/event_list_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    Event args = ModalRoute.of(context)?.settings.arguments as Event;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    TextEditingController titleController = TextEditingController(
      text: args.title,
    );
    TextEditingController descriptionController = TextEditingController(
      text: args.description,
    );
    List<String> eventNameList = [
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
    List<String> eventImageLightList = [
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
    int selectedIndex = 0;

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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(args.image),
              ),
              SizedBox(height: height * .02),
              SizedBox(
                height: height * .04,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // selectedIndex = index;
                        // setState(() {});
                        if (args.eventName == eventNameList[index]) {
                          selectedIndex = index;
                        }
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
                        isSelected: args.eventName == eventNameList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * .01);
                  },
                  itemCount: 9,
                ),
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.titleMedium,
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
                style: Theme.of(context).textTheme.titleMedium,
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
                chooseDateOrTime: DateFormat(
                  'dd/MM/yyyy',
                ).format(args.dateTime!),
                chooseDateOrTimeClicked: ChooseDate,
              ),
              EventDateOrTime(
                eventDateOrItemIcon: AppAssets.eventTimeIcon,
                eventDateOrItemName: AppLocalizations.of(context)!.event_time,
                chooseDateOrTime: args.time,
                chooseDateOrTimeClicked: ChooseTime,
              ),
              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.location,
                style: Theme.of(context).textTheme.titleMedium,
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
                  onPressed: updateEvent,
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
  }

  void ChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  void updateEvent() {}
}
