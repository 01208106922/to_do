
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_flutter_todo/provider/add_event_provider.dart';
import 'package:route_flutter_todo/provider/my_provider.dart';
import 'package:route_flutter_todo/provider/user_provider.dart';
import 'package:route_flutter_todo/screens/add_event_screen.dart';
import 'package:route_flutter_todo/screens/event_details.dart';
import 'package:route_flutter_todo/screens/foreget_password_screen.dart';
import 'package:route_flutter_todo/screens/home_screens/home_screen.dart';
import 'package:route_flutter_todo/screens/home_screens/love_tab.dart';
import 'package:route_flutter_todo/screens/home_screens/map_tab.dart';
import 'package:route_flutter_todo/screens/home_screens/profile_tab.dart';
import 'package:route_flutter_todo/screens/login_screen.dart';
import 'package:route_flutter_todo/screens/onboard_screen.dart';
import 'package:route_flutter_todo/screens/register/register_screen.dart';
import 'package:route_flutter_todo/screens/welcome_screen.dart';
import 'package:route_flutter_todo/theme/base_theme.dart';
import 'package:route_flutter_todo/theme/dark_theme.dart';
import 'package:route_flutter_todo/theme/lgiht_theme.dart';

import 'Splash_screen.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);

    return true;
  };
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddEventProvider(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provier = Provider.of<MyProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    BaseTheme theme = LightTheme();
    BaseTheme darkTheme = DarkTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme.themeData,
      darkTheme: darkTheme.themeData,
      themeMode: provier.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.firebaseUser != null
          ?  HomeScreen.routeName
          : SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        OnboardScreen.routeName: (context) => OnboardScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForegetPasswordScreen.routeName: (context) => ForegetPasswordScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddEventsScreen.routeName: (context) => AddEventsScreen(),
        ProfileTab.routeName: (context) => ProfileTab(),
        MapTab.routeName: (context) => MapTab(),
        LoveTab.routeName: (context) => LoveTab(),
        EventDetails.routeName: (context) => EventDetails(),
      },
    );
  }
}