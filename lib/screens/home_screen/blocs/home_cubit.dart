import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';

import '../service/Service/HomeService.dart';

class HomeCubit extends Cubit<HomeState> implements ActivityListener {
  List<AddActivityModel> activities = [];

  HomeCubit(HomeState initial) : super(initial) {
    loadActivities();
  }
  HomeService service = HomeService();

  loadActivities() async {
    loading();
    activities = await service.getActivities(this);
  }

  @override
  void loading() {
    emit(HomeState.loading);
  }

  @override
  void success() {
    emit(HomeState.success);
  }
}

enum HomeState { success, initial, loading }

abstract class ActivityListener {
  void success();
  void loading();
}
