import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/core/config/sized_config.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/data/components/background.dart';
import 'package:flutter_group_on/screens/activity_screen/activity_cubit.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => ActivityCubit(),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: backGroundDecoration(),
        ),
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
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
