import 'package:flutter/material.dart';

class EventCategoryItem extends StatelessWidget {
  String title;
  bool isSelected;

  EventCategoryItem({required this.title, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color:
          isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor),
      ),
    );
  }
}