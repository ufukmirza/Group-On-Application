import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_group_on/data/models/user_model.dart';
import 'package:flutter_group_on/screens/add_activity_screen/blocs/add_activity_bloc.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';
import 'package:uuid/uuid.dart';

class AddActivityService {
  Future<void> addActivityToFirebase(
      AddActivityModel activity, ActivityListener listener) async {
    CollectionReference activities =
        FirebaseFirestore.instance.collection('activities');
    var uid = Uuid();
    var randomUuid = uid.v4();
    await activities.doc(randomUuid).set({
      'activityUid': randomUuid,
      'userUid': activity.userUid,
      'activityName': activity.activityName,
      'userName': activity.userName,
      'activityDeclarition': activity.activityDeclarition,
      'activityLocation': activity.activityLocation,
      'activityTypes': activity.activityTypes,
      'activityUserLimit': activity.activityUserLimit,
      'activityTime': activity.activityTime,
      'imageUrl': activity.imageUrl
    });
    List<dynamic>? createdActivities = [];
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(AppUser.userUid).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      print(data["createdActivities"]);
      createdActivities = data["createdActivities"];
    });

    createdActivities == null
        ? createdActivities = [randomUuid] as dynamic
        : createdActivities!.add(randomUuid);
    print(createdActivities);
    await users
        .doc(AppUser().getUserUid())
        .update({'createdActivities': createdActivities});

/*
  await activities.add({
      'activityUid':
      'userUid': activity.userUid,
      'activityName': activity.activityName,
      'userName': activity.userName,
      'activityDeclarition': activity.activityDeclarition,
      'activityLocation': activity.activityLocation,
      'activityTypes': activity.activityTypes,
      'activityUserLimit': activity.activityUserLimit,
      'activityTime': activity.activityTime,
      'imageUrl': activity.imageUrl
    });*/
  }
}
