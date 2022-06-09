import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/screens/login_screen/login_cubit.dart';

import '../../../core/config/sized_config.dart';
import '../../../core/constants/colors/color_constants.dart';
import '../../../core/constants/screens/screen_constants.dart';
import '../../../data/components/background.dart';

class LoginScreen extends StatelessWidget {
  bool _passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: Stack(children: [
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
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is PasswordChangeState)
                      _passwordVisible = !_passwordVisible;

                    if (state is NoUserFoundState)
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
                        message: 'Kullanıcı bulunamadı',
                      ).show(context);

                    if (state is wrongPasswordState) {
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
                        message: 'Hatalı Şifre',
                      ).show(context);
                    }

                    if (state is AuthedUserState)
                      Navigator.pushNamedAndRemoveUntil(
                          context, tabview, (Route<dynamic> route) => false);
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
                                    controller: _emailController,
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
                                              .read<LoginCubit>()
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                // textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Sana yazar');
                                        }),
                                ]),
                              ),
                              RichText(
                                // textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'Üye Ol',
                                      style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, signInScreen);
                                        })
                                ]),
                              ),
                            ],
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
                              onPressed: () {
                                context.read<LoginCubit>().postLoginCredentials(
                                    _emailController.text,
                                    _passwordController.text);
                              },
                              child: Text(
                                "Giriş",
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
