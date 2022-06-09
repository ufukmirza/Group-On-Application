import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_on/data/models/user_model.dart';
import 'package:flutter_group_on/screens/account_screen/bloc/add_image.dart';
import 'package:flutter_group_on/screens/account_screen/view/accountListActivityItem.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';
import 'package:flutter_group_on/screens/home_screen/widgets/list_activity_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/sized_config.dart';
import '../../../data/components/background.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
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
          right: 0,
          left: 0,
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(30),
                  horizontal: getProportionateScreenHeight(30),
                ),
                child: Column(
                  children: [
                    Expanded(child: AccountProfileComponent()),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Expanded(child: CommentBuilder()),
                  ],
                ),
              )),
              Expanded(child: AccountStatus())
            ],
          ))
    ]));
  }
}

class AccountProfileComponent extends StatefulWidget {
  @override
  State<AccountProfileComponent> createState() =>
      _AccountProfileComponentState();
}

class _AccountProfileComponentState extends State<AccountProfileComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                flex: 4,
                child: Container(
                    child: Padding(
                  padding: EdgeInsets.all(5),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final radius = constraints.maxHeight * 3 / 5;

                      return Center(
                        child: GestureDetector(
                          onTap: () => _showImageSourceActionSheet(context),
                          child: CircleAvatar(
                            radius: radius,
                            backgroundImage: NetworkImage(AppUser.userImage),
                          ),
                        ),
                      );
                    },
                  ),
                ))),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppUser.userName),
                      Row(
                        children: [
                          Text("3,5"),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                pickAImage(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                //    selectImageSource(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () async {
              Navigator.pop(context);
              await pickAImage(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Gallery'),
            onTap: () async {
              Navigator.pop(context);
              await pickGallery();
            },
          ),
        ]),
      );
    }
  }

  Future<void> pickAImage(BuildContext context) async {
    final picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    Directory appDirectory = await getApplicationDocumentsDirectory();
    File newImage = File(appDirectory.path + 'fileName');
    newImage.writeAsBytes(File(photo!.path).readAsBytesSync());
    print("sasas");
    var url = await addImageToFireStorage(newImage);
    print("sasas");
    await addImageToUser(url);
    setState(() {});
  }

  pickGallery() async {
    final picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    Directory appDirectory = await getApplicationDocumentsDirectory();
    File newImage = File(appDirectory.path + 'fileName');
    newImage.writeAsBytes(File(photo!.path).readAsBytesSync());
    print("sasas");
    var url = await addImageToFireStorage(newImage);
    await addImageToUser(url);
    setState(() {});
    print("sasas");
  }
}

class CommentBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Align(
            alignment: Alignment.topLeft,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                getCommentWidget("saa"),
                getCommentWidget("Bu adam mükemmel"),
                getCommentWidget(
                    "en yakın sürede tekrar etkinlik yapmamız lazım sssssssssssss"),
                getCommentWidget("dostumla maç yapmak harikaydı")
              ],
            )),
      ),
    );
  }

  Widget getCommentWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountStatus extends StatefulWidget {
  AccountStatus({Key? key}) : super(key: key);

  @override
  State<AccountStatus> createState() => _AccountStatusState();
}

class _AccountStatusState extends State<AccountStatus> {
  var isCreatedActivities = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isCreatedActivities = true;
                  });
                },
                child: Container(
                  child: Column(children: [
                    isCreatedActivities
                        ? Text(
                            "Oluşturulan Aktiviteler",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            "Oluşturulan Aktiviteler",
                            style: TextStyle(color: Colors.grey),
                          ),
                    isCreatedActivities
                        ? Divider(
                            color: Colors.white,
                            thickness: 1,
                          )
                        : Divider(
                            color: Colors.grey,
                          )
                  ]),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isCreatedActivities = false;
                  });
                },
                child: Container(
                  child: Column(children: [
                    isCreatedActivities
                        ? Text(
                            "Katılınan Aktiviteler",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(
                            "Katılınan Aktiviteler",
                            style: TextStyle(color: Colors.white),
                          ),
                    isCreatedActivities
                        ? Divider(
                            color: Colors.grey,
                          )
                        : Divider(
                            color: Colors.white,
                            thickness: 1,
                          )
                  ]),
                ),
              ),
            ),
          ],
        ),
        Expanded(
            child: isCreatedActivities == true
                ? FutureBuilder(
                    future: getActivities(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                              width: getProportionateScreenWidth(10),
                            ),
                          );
                        } else {
                          var data = snapshot.data as List<AddActivityModel>;
                          if (data != null) {}

                          return Center(
                              child: data != null
                                  ? ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListActivityItem(
                                            activity: data[index]);
                                      })
                                  : Text("No Activity"));
                        }
                      } else if (snapshot.hasError) {
                        return Text('no data');
                      }
                      return CircularProgressIndicator();
                    },
                  )
                : FutureBuilder(
                    future: getJoinedActivities(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                              width: getProportionateScreenWidth(10),
                            ),
                          );
                        } else {
                          var data = snapshot.data as List<AddActivityModel>;
                          if (data != null) {}

                          return Center(
                              child: data != null
                                  ? ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListActivityItem(
                                            activity: data[index]);
                                      })
                                  : Text("No Activity"));
                        }
                      } else if (snapshot.hasError) {
                        return Text('no data');
                      }
                      return CircularProgressIndicator();
                    },
                  ))
      ],
    );
  }

  Future<List<AddActivityModel>> getActivities() async {
    List<dynamic>? createdActivities = [];
    List<AddActivityModel> activities = [];

    var a = await FirebaseFirestore.instance
        .collection("users")
        .doc(AppUser.userUid)
        .get()
        .then((value) => value.data());

    var data = a as Map<String, dynamic>;
    if (data["createdActivities"] != null) {
      // print(data["createdActivities"]);
      List activitiesUid =
          data["createdActivities"].map((e) => e.toString()).toList();
      print(activitiesUid[0]);

      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('activities');

      await Future.forEach(activitiesUid, (element) async {
        await _collectionRef.doc(element as String).get().then((value) {
          activities.add(
              AddActivityModel.fromJson(value.data() as Map<String, dynamic>));
          print(activities[0].activityLocation);
        });
      });
    }

    return activities;
  }

  Future<List<AddActivityModel>> getJoinedActivities() async {
    List<dynamic>? joinedActivities = [];
    List<AddActivityModel> activities = [];

    var a = await FirebaseFirestore.instance
        .collection("users")
        .doc(AppUser.userUid)
        .get()
        .then((value) => value.data());

    var data = a as Map<String, dynamic>;
    if (data["joinedActivities"] != null) {
      // print(data["createdActivities"]);
      List activitiesUid =
          data["joinedActivities"].map((e) => e.toString()).toList();
      print(activitiesUid[0]);

      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('activities');

      await Future.forEach(activitiesUid, (element) async {
        await _collectionRef.doc(element as String).get().then((value) {
          activities.add(
              AddActivityModel.fromJson(value.data() as Map<String, dynamic>));
          print(activities[0].activityLocation);
        });
      });
    }

    return activities;
  }
}
