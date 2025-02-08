import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../firebase/firebase_manager.dart';
import '../../provider/my_provider.dart';
import '../../provider/user_provider.dart';
import '../login_screen.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});
  static const String routeName = "ProfileTab";

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController nameController = TextEditingController();
  String _selectedLanguage = 'ar';
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    var provier = Provider.of<MyProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 174,
        centerTitle: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              child: Image.asset(
                "assets/images/route.jpeg",
                width: 124,
                height: 124,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  userProvider.userModel?.name ?? "null",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  userProvider.userModel?.email ?? "null",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "language".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: provier.themeMode == ThemeMode.light
                  ? Colors.black
                  : Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        'english'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        context.setLocale(Locale('en'));
                      },
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(
                        'arabic'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        context.setLocale(Locale('ar'));
                      },
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "theme".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: provier.themeMode == ThemeMode.light
                  ? Colors.black
                  : Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTheme,
                  items: [
                    DropdownMenuItem(
                      value: 'Light',
                      child: Text(
                        'light'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        provier.themeMode = ThemeMode.light;
                      },
                    ),
                    DropdownMenuItem(
                      value: 'Dark',
                      child: Text(
                        'dark'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        provier.themeMode = ThemeMode.dark;
                      },
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTheme = newValue!;
                    });
                  },
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(width: 2, color: Color(0xffFF5659)),
                    color: Color(0XFFFF5659)),
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseManager.logout();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xffFF5659)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "logout".tr(),
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
