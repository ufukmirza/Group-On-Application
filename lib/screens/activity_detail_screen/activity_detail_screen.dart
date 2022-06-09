import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';

import '../../core/config/sized_config.dart';
import '../../data/components/background.dart';
import '../../data/models/user_model.dart';

class ActivityDetailScreen extends StatefulWidget {
  ActivityDetailScreen({this.activityModel, Key? key}) : super(key: key);

  AddActivityModel? activityModel;

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  var buttonShow = true;
  var isCreated = false;
  var userImage = "";

  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    if (widget.activityModel!.userUid == AppUser.userUid) {
      buttonShow = false;
      isCreated = true;
    }

    print(buttonShow);

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
            child: FutureBuilder(
                future: CheckState(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              child: Image.network(
                                  widget.activityModel!.imageUrl!),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child:
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                  // ignore: dead_code
                                  children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userImage),
                                          radius:
                                              getProportionateScreenHeight(25),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(widget.activityModel!.userName!),
                                        VerticalDivider(
                                          thickness: 0.5,
                                          color: Color(0xdffC4C4C4),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("4,5"),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: Color(0xdffC4C4C4),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/icons/calendar_icon.png"),
                                                Text(widget.activityModel!
                                                    .activityTime!),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/icons/location_icon.png"),
                                                Text(widget.activityModel!
                                                    .activityLocation!)
                                              ],
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.4),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    content: Builder(
                                                      builder: (context) {
                                                        // Get available height and width of the build area of this widget. Make a choice depending on the size.

                                                        return Container(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          height: SizeConfig
                                                                  .screenWidth *
                                                              3 /
                                                              4,
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              3 /
                                                              4,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: users
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return ListTile(
                                                                      leading:
                                                                          CircleAvatar(
                                                                        backgroundImage:
                                                                            NetworkImage(users[index].userImage),
                                                                        radius:
                                                                            getProportionateScreenHeight(25),
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        users[index]
                                                                            .userName,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    );
                                                                  }),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.group,
                                                color: Colors.black,
                                              ),
                                              Text(users.length.toString() +
                                                  "/"),
                                              Text(widget.activityModel!
                                                  .activityUserLimit!
                                                  .toString())
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                Divider(
                                  thickness: 1,
                                  color: Color(0xdffC4C4C4),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: ListView(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          // vertical: getProportionateScreenHeight(10),
                                          horizontal: 5,
                                          vertical:
                                              getProportionateScreenHeight(15)),
                                      child: Text(
                                        widget.activityModel!.activityName!,
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    20)),
                                      ),
                                    ),
                                    Text(widget
                                        .activityModel!.activityDeclarition!)
                                  ]),
                                ),
                                buttonShow == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: OutlinedButton(
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<
                                                      EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          getProportionateScreenWidth(
                                                              40),
                                                      vertical:
                                                          getProportionateScreenHeight(
                                                              20))),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff6C14A3)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12))),
                                            ),
                                            onPressed: () async {
                                              var isFulll = false;
                                              var isJoined = false;

                                              await FirebaseFirestore.instance
                                                  .collection('activities')
                                                  .doc(widget.activityModel!
                                                      .activityUid)
                                                  .get()
                                                  .then((value) {
                                                var data = value.data()
                                                    as Map<String, dynamic>;

                                                if (data["joinedPersons"]
                                                        ?.length ==
                                                    widget.activityModel!
                                                        .activityUserLimit)
                                                  isFulll = true;
                                              });

                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(AppUser.userUid)
                                                  .get()
                                                  .then((value) {
                                                var data = value.data()
                                                    as Map<String, dynamic>;

                                                if (data["joinedActivities"] !=
                                                        null &&
                                                    data["joinedActivities"]
                                                        .contains(widget
                                                            .activityModel!
                                                            .activityUid))
                                                  isJoined = true;

                                                if (data["createdActivities"] !=
                                                        null &&
                                                    data["createdActivities"]
                                                        .contains(widget
                                                            .activityModel!
                                                            .activityUid))
                                                  isJoined = true;
                                              });

                                              if (isFulll == false &&
                                                  isJoined == false) {
                                                List<dynamic>?
                                                    joinedActivities = [];
                                                CollectionReference users =
                                                    FirebaseFirestore.instance
                                                        .collection('users');
                                                await users
                                                    .doc(AppUser.userUid)
                                                    .get()
                                                    .then((value) {
                                                  var data = value.data()
                                                      as Map<String, dynamic>;
                                                  //  print(
                                                  //    data["joinedActivities"]);
                                                  joinedActivities =
                                                      data["joinedActivities"];
                                                });

                                                joinedActivities == null
                                                    ? joinedActivities = [
                                                        widget.activityModel!
                                                            .activityUid
                                                      ] as dynamic
                                                    : joinedActivities!.add(
                                                        widget.activityModel!
                                                            .activityUid);
                                                // print(joinedActivities);
                                                await users
                                                    .doc(AppUser().getUserUid())
                                                    .update({
                                                  'joinedActivities':
                                                      joinedActivities
                                                });

                                                // Kullanıcıyı etkinliğe ekleme

                                                List<dynamic>? joinedPersons =
                                                    [];
                                                await FirebaseFirestore.instance
                                                    .collection('activities')
                                                    .doc(widget.activityModel!
                                                        .activityUid)
                                                    .get()
                                                    .then((value) {
                                                  var data = value.data()
                                                      as Map<String, dynamic>;
                                                  // print(data["joinedPersons"]);
                                                  joinedPersons =
                                                      data["joinedPersons"];
                                                });

                                                joinedPersons == null
                                                    ? joinedPersons = [
                                                        AppUser().getUserUid()
                                                      ] as dynamic
                                                    : joinedPersons!.add(
                                                        AppUser().getUserUid());
                                                //print(joinedPersons);
                                                await FirebaseFirestore.instance
                                                    .collection('activities')
                                                    .doc(widget.activityModel!
                                                        .activityUid)
                                                    .update({
                                                  'joinedPersons': joinedPersons
                                                });

                                                setState(() {});
                                              }
                                            },
                                            child: Text(
                                              "KATIL",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  color: Colors.white),
                                            )),
                                      )
                                    : isCreated == true
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: OutlinedButton(
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty.all<
                                                          EdgeInsets>(
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              getProportionateScreenWidth(
                                                                  40),
                                                          vertical:
                                                              getProportionateScreenHeight(
                                                                  20))),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color(0xff6C14A3)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12))),
                                                ),
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('activities')
                                                      .doc(widget.activityModel!
                                                          .activityUid)
                                                      .get()
                                                      .then((value) async {
                                                    var data = value.data()
                                                        as Map<String, dynamic>;

                                                    var joinedPersons =
                                                        data["joinedPersons"];

                                                    if (joinedPersons != null)
                                                      await Future.forEach(
                                                          joinedPersons,
                                                          (element) async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(element
                                                                .toString())
                                                            .get()
                                                            .then(
                                                                (value) async {
                                                          var data =
                                                              value.data()
                                                                  as Map<String,
                                                                      dynamic>;

                                                          List
                                                              joinedActivities =
                                                              data[
                                                                  "joinedActivities"];
                                                          joinedActivities
                                                              .remove(widget
                                                                  .activityModel!
                                                                  .activityUid);

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(element
                                                                  .toString())
                                                              .update({
                                                            'joinedActivities':
                                                                joinedActivities
                                                          });
                                                        });
                                                      });
                                                  });

                                                  //kullanıcılardan oluşturulan aktiviteyi kaldırmaaaaa

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(widget.activityModel!
                                                          .userUid)
                                                      .get()
                                                      .then((value) async {
                                                    var data = value.data()
                                                        as Map<String, dynamic>;

                                                    List createdActivities =
                                                        data[
                                                            "createdActivities"];
                                                    createdActivities.remove(
                                                        widget.activityModel!
                                                            .activityUid);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(widget
                                                            .activityModel!
                                                            .userUid)
                                                        .update({
                                                      'createdActivities':
                                                          createdActivities
                                                    });
                                                  });

                                                  //aktiviteyi aktivitelerden kaldırmaaaa

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('activities')
                                                      .doc(widget.activityModel!
                                                          .activityUid)
                                                      .delete();

                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          tabview,
                                                          (route) => false);
                                                },
                                                child: Text(
                                                  "Kaldır",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              20),
                                                      color: Colors.white),
                                                )),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: OutlinedButton(
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty.all<
                                                          EdgeInsets>(
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              getProportionateScreenWidth(
                                                                  40),
                                                          vertical:
                                                              getProportionateScreenHeight(
                                                                  20))),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color(0xff6C14A3)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12))),
                                                ),
                                                onPressed: () async {
//kullanıcıyı aktiviteden kaldırma

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('activities')
                                                      .doc(widget!
                                                          .activityModel!
                                                          .activityUid)
                                                      .get()
                                                      .then((value) async {
                                                    var data = value.data()
                                                        as Map<String, dynamic>;
                                                    List joinedPersons =
                                                        data["joinedPersons"];
                                                    joinedPersons.remove(
                                                        AppUser.userUid);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'activities')
                                                        .doc(widget!
                                                            .activityModel!
                                                            .activityUid)
                                                        .update({
                                                      'joinedPersons':
                                                          joinedPersons
                                                    });
                                                  });

/////
                                                  ///
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(AppUser.userUid)
                                                      .get()
                                                      .then((value) async {
                                                    var data = value.data()
                                                        as Map<String, dynamic>;
                                                    List joinedActivities =
                                                        data[
                                                            "joinedActivities"];
                                                    joinedActivities.remove(
                                                        widget!.activityModel!
                                                            .activityUid);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(AppUser.userUid)
                                                        .update({
                                                      'joinedActivities':
                                                          joinedActivities
                                                    });
                                                  });

                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          tabview,
                                                          (route) => false);
                                                },
                                                child: Text(
                                                  "Aktiviteden Çık",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              20),
                                                      color: Colors.white),
                                                )),
                                          )
                              ]),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }))
      ],
    ));
  }

  CheckState() async {
    await FirebaseFirestore.instance
        .collection('activities')
        .doc(widget.activityModel!.activityUid)
        .get()
        .then((value) async {
      var data = value.data() as Map<String, dynamic>;

      if (data["joinedPersons"]?.length ==
          widget.activityModel!.activityUserLimit) buttonShow = false;

      var joinedPersons = data["joinedPersons"];

      //print(joinedPersons);
//bura guncellenebilir;,,,,
      if (joinedPersons != null)
        await Future.forEach(joinedPersons, (element) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.toString())
              .get()
              .then((value) {
            var data = value.data() as Map<String, dynamic>;

            users.add(
                User(userName: data["userName"], userImage: data["userImage"]));
          });
        });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppUser.userUid)
        .get()
        .then((value) {
      var data = value.data() as Map<String, dynamic>;

      if (data["joinedActivities"] != null &&
          data["joinedActivities"].contains(widget.activityModel!.activityUid))
        buttonShow = false;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.activityModel!.userUid)
        .get()
        .then((value) {
      var data = value.data() as Map<String, dynamic>;
      userImage = data["userImage"];
    });

    return true;
  }
}

class User {
  String userName = "";
  String userImage = "";

  User({required this.userName, required this.userImage});
}
