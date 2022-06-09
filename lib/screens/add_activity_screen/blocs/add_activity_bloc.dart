import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/add_activity_screen/services/add_activity_service.dart';

import '../model/add_activity_model.dart';

class AddActivityCubit extends Cubit<AddActivityState>
    implements ActivityListener {
  AddActivityCubit(AddActivityState initialState) : super(initialState);

  final AddActivityService service = AddActivityService();

  addActivity(AddActivityModel activity) async {
    await service.addActivityToFirebase(activity, this);
  }

  @override
  void success() {
    emit(AddActivityState.success);
  }
}

enum AddActivityState { success, initial }

abstract class ActivityListener {
  void success();
}
