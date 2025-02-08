import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:route_flutter_todo/provider/my_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'login_screen.dart';
import 'onboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = "WelcomeScreen";

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provier = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Logo.png",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/header.png",
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              context.tr('introduction_title'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              "introduction_desc".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("language".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor)),
                ToggleSwitch(
                  minWidth: 73.0,
                  minHeight: 30.0,
                  initialLabelIndex: context.locale.toString() == "en" ? 0 : 1,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: [
                    FontAwesomeIcons.flagUsa,
                    MdiIcons.abjadArabic,
                  ],
                  iconSize: 30.0,
                  activeBgColors: [
                    context.locale.toString() == "en"
                        ? [
                      Theme.of(context).primaryColor,
                      Theme.of(context).secondaryHeaderColor
                    ]
                        : [Colors.yellow, Colors.orange],
                    context.locale.toString() != "en"
                        ? [
                      Theme.of(context).primaryColor,
                      Theme.of(context).secondaryHeaderColor
                    ]
                        : [Colors.yellow, Colors.orange],
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    if (index == 0) {
                      context.setLocale(Locale('en'));
                    } else {
                      context.setLocale(Locale('ar'));
                    }

                    print('switched to: $index');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("theme".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor)),
                ToggleSwitch(
                  minWidth: 73.0,
                  minHeight: 30.0,
                  initialLabelIndex:
                  provier.themeMode == ThemeMode.light ? 0 : 1,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: const [
                    FontAwesomeIcons.lightbulb,
                    FontAwesomeIcons.moon,
                  ],
                  iconSize: 30.0,
                  activeBgColors: [
                    provier.themeMode == ThemeMode.light
                        ? [Colors.yellow, Colors.orange]
                        : [
                      Theme.of(context).primaryColor,
                      Theme.of(context).secondaryHeaderColor
                    ],
                    provier.themeMode != ThemeMode.light
                        ? [Colors.yellow, Colors.orange]
                        : [
                      Theme.of(context).primaryColor,
                      Theme.of(context).secondaryHeaderColor
                    ]
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    provier.changeTheme();
                    print('switched to: $index');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, OnboardScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                child: Text("lets_start".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}