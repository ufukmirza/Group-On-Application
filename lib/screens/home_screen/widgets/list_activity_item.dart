import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/screens/activity_detail_screen/activity_detail_screen.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';

import '../../../core/config/sized_config.dart';

class ListActivityItem extends StatelessWidget {
  ListActivityItem({required this.activity, Key? key}) : super(key: key);
  AddActivityModel activity;
  var userImage = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(184),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, activityDetailScreen);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActivityDetailScreen(
                          activityModel: activity,
                        )));
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
            child: Stack(fit: StackFit.expand, children: [
              FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  child: Image.network(activity.imageUrl!),
                ),
              ),
              Positioned(
                top: getProportionateScreenHeight(5),
                left: getProportionateScreenWidth(5),
                child: Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    FutureBuilder(
                        future: getImage(activity),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(userImage),
                              backgroundColor: Colors.transparent,
                            );
                          } else
                            return CircularProgressIndicator();
                        }),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Text(
                      activity.userName!,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: getProportionateScreenHeight(0),
                child: Container(
                    child: Column(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          activity.activityName!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenHeight(25),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/icons/calendar_icon.png"),
                                  Text(activity.activityTime!),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/icons/location_icon.png"),
                                  Text(activity.activityLocation!)
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: Colors.white,
                              ),
                              Text(activity.activityUserLimit!.toString())
                            ],
                          )
                        ],
                      )
                    ]),
                    width: SizeConfig.screenWidth,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ]),
          ),
        );
      }),
    );
  }

  getImage(AddActivityModel activity) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(activity!.userUid)
        .get()
        .then((value) {
      var data = value.data() as Map<String, dynamic>;
      userImage = data["userImage"];
    });
    print("girdi buraya");

    return true;
  }
}
