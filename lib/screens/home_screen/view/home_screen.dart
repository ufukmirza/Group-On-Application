import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/home_screen/blocs/home_cubit.dart';
import 'package:flutter_group_on/screens/home_screen/widgets/list_activity_item.dart';

import '../../../core/config/sized_config.dart';
import '../../../core/constants/screens/screen_constants.dart';
import '../../../data/components/background.dart';
import '../blocs/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var loading = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeState.initial),
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: getProportionateScreenHeight(32),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(20)),
                color: Colors.white),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextField(
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(14)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Kullanıcı adı',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/icons/search_icon.png")),
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/icons/filter_icon.png"))
          ],
          backgroundColor: Colors.black.withOpacity(0.5),
          elevation: 0,
        ),
        body: Stack(children: [
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
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state == HomeState.loading) {
                loading = true;
              }
              if (state == HomeState.success) {
                loading = false;
              }
            },
            builder: (context, state) {
              return Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: loading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount:
                              context.read<HomeCubit>().activities.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListActivityItem(
                              activity:
                                  context.read<HomeCubit>().activities[index],
                            );
                          },
                        ));
            },
          )
        ]));
  }
}
