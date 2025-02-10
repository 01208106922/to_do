import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_flutter_todo/screens/register/register_connector.dart';
import 'package:route_flutter_todo/screens/register/register_viewmodel.dart';
import '../../provider/my_provider.dart';
import '../login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterConnector{
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<MyProvider>(context);
    var viewModel = RegisterViewModel();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("register".tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                    TextFormField(
                      style: themeProvider.themeMode==ThemeMode.light?TextStyle(color: Colors.black):
                      TextStyle(color: Colors.white),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is Required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "name".tr(),
                        hintStyle: TextStyle(color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                        prefixIcon: Icon(Icons.person,
                            color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: themeProvider.themeMode==ThemeMode.light?TextStyle(color: Colors.black):
                      TextStyle(color: Colors.white),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is Required";
                        }
                        final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                            .hasMatch(value);

                        if (emailValid == false) {
                          return "Email not Valid";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "email".tr(),
                        hintStyle: TextStyle(   color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                        prefixIcon: Icon(Icons.email,   color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: themeProvider.themeMode==ThemeMode.light?TextStyle(color: Colors.black):
                      TextStyle(color: Colors.white),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is Required";
                        }
                        if (value.length < 6) {
                          return "Password should be at least 6 Char";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "password".tr(),
                        hintStyle: TextStyle(   color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                        suffixIcon: Icon(Icons.visibility,   color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: themeProvider.themeMode==ThemeMode.light?TextStyle(color: Colors.black):
                      TextStyle(color: Colors.white),
                      controller: rePasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Re-Password is Required";
                        }
                        if (value.length < 6) {
                          return "Password should be at least 6 Char";
                        }

                        if (passwordController.text != value) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "rePassword".tr(),
                        hintStyle: TextStyle(   color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                        suffixIcon: Icon(Icons.visibility,   color:themeProvider.themeMode==ThemeMode.light? Colors.black:
                        Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          viewModel.createAccount(
                            nameController.text,
                            emailController.text,
                            passwordController.text,

                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      child: Text("create_account".tr(),
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
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "already_have_account".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "login".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  showErrorMessage({String? error}) {
        (message) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("Something went Wrong"),
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"))
          ],
        ),
      );
    };
  }

  @override
  showLoading() {
        () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
          Center(child: CircularProgressIndicator()),
          backgroundColor: Colors.transparent,
        ),
      );
    };
  }

  @override
  showSuccessMessage() {

        () {
      Navigator.pop(context);
      Navigator.pop(context);
    };
  }
}