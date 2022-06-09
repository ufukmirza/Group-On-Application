import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/core/config/sized_config.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/screens/activity_screen/view/activity_screen.dart';
import 'package:flutter_group_on/screens/add_activity_screen/view/add_activity_screen.dart';
import 'package:flutter_group_on/screens/home_screen/view/home_screen.dart';
import 'package:flutter_group_on/screens/login_screen/view/login_screen.dart';
import 'package:flutter_group_on/screens/sign_in_screen/view/sign_in_screen.dart';
import 'package:flutter_group_on/screens/sign_in_screen/view_model/sign_in_cubit.dart';

import 'core/routers/router_class.dart';
import 'data/components/background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onGenerateRoute: RouterDart.generateRoute,
        initialRoute: loginScreen,
        home: LoginScreen());
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(children: [
      Container(decoration: backGroundDecoration()),
      Positioned(
        child: topLeftClipOval(),
        top: getProportionateScreenHeight(-47),
        left: getProportionateScreenHeight(-60),
      ),
      Positioned(
        child: bottomRightClipOval(),
        top: getProportionateScreenHeight(SizeConfig.screenHeight - 100),
        right: getProportionateScreenHeight(-110),
      ),
      Align(
        alignment: Alignment.center,
        child: Image.asset("assets/images/Group_On_5.png"),
      )
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
