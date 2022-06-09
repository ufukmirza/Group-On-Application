import 'package:flutter/material.dart';
import 'package:flutter_group_on/main.dart';
import 'package:flutter_group_on/screens/account_screen/view/account_screen.dart';
import 'package:flutter_group_on/screens/activity_screen/view/activity_screen.dart';
import 'package:flutter_group_on/screens/add_activity_screen/view/add_activity_screen.dart';
import 'package:flutter_group_on/screens/home_screen/view/home_screen.dart';
import 'package:flutter_group_on/screens/tabview/tab_view.dart';
import '../../screens/activity_detail_screen/activity_detail_screen.dart';
import '../../screens/login_screen/view/login_screen.dart';
import '../../screens/sign_in_screen/view/sign_in_screen.dart';
import '../constants/screens/screen_constants.dart';

class RouterDart {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case signInScreen:
      // return MaterialPageRoute(builder: (_) => SignInScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case activityScreen:
        return MaterialPageRoute(builder: (_) => ActivityScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case activityDetailScreen:
        return MaterialPageRoute(builder: (_) => ActivityDetailScreen());
      case addActivityScreen:
        return MaterialPageRoute(builder: (_) => AddActivityScreen());
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case tabview:
        return MaterialPageRoute(builder: (_) => tabViewClass());
      case accountScreen:
        return MaterialPageRoute(builder: (_) => AccountScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Ters giden birşeyler oldu'),
            ),
          ),
        );
    }
  }
}
