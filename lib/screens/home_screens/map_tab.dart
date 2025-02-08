import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});
  static const String routeName = "MapTab";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
    );
  }
}