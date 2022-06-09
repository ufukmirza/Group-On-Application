import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/login_screen/service/login_service.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());
  LoginService service = LoginService();
}

abstract class ActivityState {}

class ActivityInitial extends ActivityState {}
