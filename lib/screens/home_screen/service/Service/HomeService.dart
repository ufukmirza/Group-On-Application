import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';
import 'package:flutter_group_on/screens/home_screen/blocs/home_cubit.dart';

class HomeService {
  Future<List<AddActivityModel>> getActivities(
      ActivityListener listener) async {
    print("saaa");
    CollectionReference _collectionRef =
        await FirebaseFirestore.instance.collection('activities');
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);

    // Get data from docs and convert map to List
    List<AddActivityModel> activityModels = [];

    allData.forEach((e) => activityModels
        .add(AddActivityModel.fromJson(e as Map<String, dynamic>)));

    print(activityModels[0].activityName);
    listener.success();
    return activityModels;
  }
}
