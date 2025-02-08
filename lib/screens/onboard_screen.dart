import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'login_screen.dart';

class OnboardScreen extends StatelessWidget {
  static const String routeName = "OnboardScreen";

  OnboardScreen({super.key});

  Widget _buildImage(String assetName, [double width = 357]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).primaryColor,
      ),
      bodyTextStyle: Theme.of(context).textTheme.titleSmall!,
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imagePadding: EdgeInsets.zero,
      imageFlex: 2,
    );

    return IntroductionScreen(
      globalHeader: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Image.asset(
          "assets/images/pic.png",
          width: 159,
          height: 50,
        ),
      ),
      dotsFlex: 2,
      dotsDecorator: DotsDecorator(
        color: Colors.black,
        activeColor: Theme.of(context).primaryColor,
      ),
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onDone: () async {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      showDoneButton: true,
      done: Image.asset("assets/images/next.png"),
      showNextButton: true,
      next: Image.asset("assets/images/next.png"),
      showBackButton: true,
      back: Image.asset("assets/images/back.png"),
      pages: [
        PageViewModel(
          titleWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Find Events That Inspire You",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          bodyWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.start,
            ),
          ),
          image: _buildImage('pic1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Effortless Event Planning",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          bodyWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.start,
            ),
          ),
          image: _buildImage('pic2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Connect with Friends & Share Moments",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          bodyWidget: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.start,
            ),
          ),
          image: _buildImage('pic3.png'),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
