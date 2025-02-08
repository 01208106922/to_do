import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../firebase/firebase_manager.dart';
import '../models/task_model.dart';
import 'add_event_screen.dart';
import 'event_details.dart';

class EventItem extends StatefulWidget {
  final TaskModel taskModel;
  EventItem({required this.taskModel, super.key});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetails(taskModel: widget.taskModel),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        child: Container(
          height: 260,
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/${widget.taskModel.category}.png",
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Text(widget.taskModel.title),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddEventsScreen(taskModel: widget.taskModel),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, size: 24, color: Theme.of(context).primaryColor)),
                        IconButton(
                            onPressed: () {
                              FirebaseManager.deleteEvent(widget.taskModel.id);
                            },
                            icon: Icon(Icons.delete, size: 24, color: Theme.of(context).primaryColor)),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.taskModel.isFav = !widget.taskModel.isFav;
                            });
                            FirebaseManager.toggleFavorite(
                                widget.taskModel.id, widget.taskModel.isFav);
                          },
                          icon: Icon(
                            widget.taskModel.isFav ? Icons.favorite : Icons.favorite_border,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
