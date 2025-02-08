import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../provider/my_provider.dart';
import 'home_screens/map_tab.dart';

class EventDetails extends StatefulWidget {
  final TaskModel? taskModel;
  const EventDetails({super.key, this.taskModel});
  static const String routeName = "EventDetails";

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedImage;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.taskModel?.title ?? "");
    descriptionController = TextEditingController(text: widget.taskModel?.description ?? "");
    selectedImage = widget.taskModel?.category ?? "";
    selectedDate = widget.taskModel != null
        ? DateTime.fromMillisecondsSinceEpoch(widget.taskModel!.date)
        : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "event_details".tr(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.asset(
                        "assets/images/$selectedImage.png",
                        height: 225,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      titleController.text,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.date_range_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(selectedDate),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, MapTab.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.my_location,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "choose_event_location".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Theme.of(context).primaryColor)),
                      child: Text("Location",
                      style: TextStyle(
                          color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                          Colors.white
                      ),),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "description".tr(),
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                          color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                      Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      descriptionController.text,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                      Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
