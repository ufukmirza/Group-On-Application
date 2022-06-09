import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/screens/login_screen/login_cubit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_group_on/screens/sign_in_screen/view_model/sign_in_cubit.dart';
import '../../../core/config/sized_config.dart';
import '../../../core/constants/colors/color_constants.dart';
import '../../../data/components/background.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Container(decoration: backGroundDecoration()),
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: BlocConsumer<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state is PasswordChangedState)
                      _passwordVisible = !_passwordVisible;

                    if (state is noUserNameState)
                      Flushbar(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(20)),
                        borderRadius: BorderRadius.circular(8),
                        duration: Duration(seconds: 3),
                        backgroundGradient: LinearGradient(
                          colors: [kPrimaryColor],
                          stops: [1],
                        ),
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        // The default curve is Curves.easeOut
                        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                        message: 'Kullanıcı adı eksik',
                      ).show(context);

                    if (state is shortPasswordState)
                      Flushbar(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(20)),
                        borderRadius: BorderRadius.circular(8),
                        duration: Duration(seconds: 3),
                        backgroundGradient: LinearGradient(
                          colors: [kPrimaryColor],
                          stops: [1],
                        ),
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        // The default curve is Curves.easeOut
                        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                        message: 'Şifre 6 hane olmalı',
                      ).show(context);

                    if (state is wrongMailState)
                      Flushbar(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(20)),
                        borderRadius: BorderRadius.circular(8),
                        duration: Duration(seconds: 3),
                        backgroundGradient: LinearGradient(
                          colors: [kPrimaryColor],
                          stops: [1],
                        ),
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        // The default curve is Curves.easeOut
                        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                        message: 'Mail hatalı',
                      ).show(context);

                    if (state is wrongInformationState) {
                      Flushbar(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(20)),
                        borderRadius: BorderRadius.circular(8),
                        duration: Duration(seconds: 3),
                        backgroundGradient: LinearGradient(
                          colors: [kPrimaryColor],
                          stops: [1],
                        ),
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        // The default curve is Curves.easeOut
                        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                        message: 'Hatalı Bilgiler',
                      ).show(context);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            child: Image.asset("assets/images/Group_On_5.png"),
                            padding: EdgeInsets.symmetric(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(31)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: getProportionateScreenHeight(30),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _userNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'Kullanıcı adı',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(31)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: getProportionateScreenHeight(30),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'Kullanıcı maili',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(31)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: _passwordVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<SignInCubit>()
                                              .changePasswordState();
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'Kullanıcı şifresi',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          OutlinedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(40),
                                        vertical:
                                            getProportionateScreenHeight(20))),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff6C14A3)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                              ),
                              onPressed: () async {
                                var response = await context
                                    .read<SignInCubit>()
                                    .createUser(
                                        _emailController.text,
                                        _passwordController.text,
                                        _userNameController.text);
                                print(response);
                                if (response == true) Navigator.pop(context);
                              },
                              child: Text(
                                "Kaydet",
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(20),
                                    color: Colors.white),
                              )),
                        ]);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
