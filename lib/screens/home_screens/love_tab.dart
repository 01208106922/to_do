import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../firebase/firebase_manager.dart';
import '../../models/task_model.dart';
import '../../provider/my_provider.dart';
import '../event_item.dart';

class LoveTab extends StatefulWidget {
  static const String routeName = "LoveTab";

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<MyProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                style: themeProvider.themeMode == ThemeMode.light
                    ? TextStyle(color:Theme.of(context).primaryColor)
                    : TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "search_for_event".tr(),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot<TaskModel>>(
                  stream: FirebaseManager.getFavoriteEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No Favorite Events Yet", style: TextStyle(fontSize: 18, color: Colors.grey)));
                    }

                    var favoriteEvents = snapshot.data!.docs
                        .map((doc) => doc.data())
                        .where((task) => task.title.toLowerCase().contains(searchQuery))
                        .toList();

                    return ListView.builder(
                      itemCount: favoriteEvents.length,
                      itemBuilder: (context, index) {
                        return EventItem(taskModel: favoriteEvents[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
