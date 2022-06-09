import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/login_screen/service/login_service.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  LoginService service = LoginService();

  changePasswordState() {
    emit(PasswordChangedState());
  }

  createUser(String userEmail, String password, String userName) async {
    var response =
        await service.saveUserCredentials(userEmail, password, userName);

    if (userName.isEmpty)
      emit(noUserNameState());
    else if (!userEmail.contains("@hotmail") && !userEmail.contains("@gmail")) {
      emit(wrongMailState());
      print(userEmail);
    } else if (password.length < 6) {
      print("girdiiii");
      emit(shortPasswordState());
    }
/*
    if (response == false)
      emit(wrongInformationState());*/
    else
      return response;
  }
}

abstract class SignInState {}

class SignInInitial extends SignInState {}

class PasswordChangedState extends SignInState {}

class wrongInformationState extends SignInState {}

class noUserNameState extends SignInState {}

class wrongMailState extends SignInState {}

class shortPasswordState extends SignInState {}
