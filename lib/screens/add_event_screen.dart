import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase/firebase_manager.dart';
import '../models/task_model.dart';
import '../provider/add_event_provider.dart';
import '../provider/my_provider.dart';
import 'event_category.dart';
import 'home_screens/map_tab.dart';

class AddEventsScreen extends StatefulWidget {
  static const String routeName = "AddEventsScreen";
  final TaskModel? taskModel;

  AddEventsScreen({super.key, this.taskModel});

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedImage;
  late DateTime selectedDate;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    if (widget.taskModel != null) {
      isEditing = true;
      titleController = TextEditingController(text: widget.taskModel!.title);
      descriptionController =
          TextEditingController(text: widget.taskModel!.description);
      selectedImage = widget.taskModel!.category;
      selectedDate =
          DateTime.fromMillisecondsSinceEpoch(widget.taskModel!.date);
    } else {
      titleController = TextEditingController();
      descriptionController = TextEditingController();
      selectedImage = "";
      selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddEventProvider>(context);
    var themeProvider = Provider.of<MyProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            isEditing ? "edit_event".tr() : "create_event".tr(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: Image.asset(
                            "assets/images/${provider.imageName}.png",
                            height: 225,
                          ),
                        ),
                        Container(
                          height: 44,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 16,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  provider.changeEventCategory(index);
                                },
                                child: EventCategoryItem(
                                  title: provider.eventsCategories[index],
                                  isSelected:
                                      provider.eventsCategories[index] ==
                                          provider.selectedEventName,
                                ),
                              );
                            },
                            itemCount: provider.eventsCategoriesLength,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text("title".tr(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color:themeProvider.themeMode==ThemeMode.light? Colors.black:Colors.white),),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: "event_title".tr(),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color:themeProvider.themeMode==ThemeMode.light? Colors.black:Colors.white),

                            prefixIcon: Icon(Icons.edit_note),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("description".tr(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: themeProvider.themeMode==ThemeMode.light? Colors.black:Colors.white),),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: descriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "event_description".tr(),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color:themeProvider.themeMode==ThemeMode.light? Colors.black:Colors.white),

                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.date_range_sharp,color: themeProvider.themeMode==ThemeMode.light? Colors.black:Colors.white),
                            SizedBox(width: 16),
                            Text("event_date".tr()),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                var chosenDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(Duration(days: 365)));

                                if (chosenDate != null) {
                                  setState(() {
                                    selectedDate = chosenDate;
                                  });
                                }
                              },
                              child: Text(
                                selectedDate.toString().substring(0, 10),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, MapTab.routeName);
                            setState(() {});

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Icon(Icons.my_location,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text("choose_event_location".tr(),
                                    textAlign: TextAlign.center, style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!.copyWith(color: Theme.of(context).primaryColor)
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              TaskModel task = TaskModel(
                                id: isEditing ? widget.taskModel!.id : "",
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                date: selectedDate.millisecondsSinceEpoch,
                                category: provider.imageName,
                                title: titleController.text,
                                description: descriptionController.text,
                              );

                              if (isEditing) {
                                FirebaseManager.updateEvent(task);
                              } else {
                                FirebaseManager.addEvent(task);
                              }

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            child: Text(
                              isEditing ? "update_event".tr() : "add_event".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ));
  }
}
