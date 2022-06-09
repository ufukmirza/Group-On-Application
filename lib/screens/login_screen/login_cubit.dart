import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/login_screen/service/login_service.dart';

import '../../data/models/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(MainInitial());
  LoginService service = LoginService();

  postLoginCredentials(String userName, String password) async {
    var serviceResponse = await service.postUserCredentials(userName, password);
    print(serviceResponse);
    if (serviceResponse == "user-not-found") {
      emit(NoUserFoundState());
    } else if (serviceResponse == "wrong-password")
      emit(wrongPasswordState());
    else if (serviceResponse == "error")
      emit(NoUserFoundState());
    else if (serviceResponse == true) {
      emit(AuthedUserState());
    }
    ;
  }

  changePasswordState() {
    emit(PasswordChangeState());
  }
}

abstract class LoginState {}

class MainInitial extends LoginState {}

class wrongPasswordState extends LoginState {}

class PasswordChangeState extends LoginState {}

class NoUserFoundState extends LoginState {}

class AuthedUserState extends LoginState {}
