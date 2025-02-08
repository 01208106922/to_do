import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../firebase/firebase_manager.dart';
import '../provider/my_provider.dart';
import '../provider/user_provider.dart';
import 'foreget_password_screen.dart';
import 'home_screens/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<MyProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/Logo.png",
                  width: 136,
                  height: 186,
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  style: themeProvider.themeMode==ThemeMode.light?TextStyle(color: Colors.black):
                  TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "email".tr(),
                    hintStyle: TextStyle(color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                    Colors.white),
                    prefixIcon: Icon(Icons.email,
                        color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  style: themeProvider.themeMode==ThemeMode.light?TextStyle(color: Colors.black):
                  TextStyle(color: Colors.white),
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "password".tr(),
                    hintStyle: TextStyle(color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                    Colors.white),
                    prefixIcon: Icon(Icons.lock,color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                    Colors.white),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForegetPasswordScreen.routeName);
                        setState(() {});
                      },
                      child: Text(
                        "forget_password".tr(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed:() {
                    FirebaseManager.login(
                      emailController.text,
                      passwordController.text,
                          () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Center(child: CircularProgressIndicator()),
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      },
                          () async {
                        Navigator.pop(context);
                        await userProvider.initUser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
                              (route) => false,
                        );
                      },
                          (message) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: const Text("Something went Wrong"),
                            content: Text(message),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  child: Text("login".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                    setState(() {});

                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "do_have_account".tr(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "create_account".tr(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(child: Divider(
                      color: Theme.of(context).primaryColor,
                      indent: 10,
                      endIndent: 40,

                    )),
                    Text(
                      textAlign: TextAlign.center,
                      "or".tr(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                    Expanded(child: Divider(
                      color: Theme.of(context).primaryColor,
                      indent: 40,
                      endIndent: 10,

                    )),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18,),
                    backgroundColor: provider.themeMode==ThemeMode.light?
                    Theme.of(context).canvasColor
                        :Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(14)),),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png"),
                      SizedBox(width: 8,),
                      Text("login_with_google".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}