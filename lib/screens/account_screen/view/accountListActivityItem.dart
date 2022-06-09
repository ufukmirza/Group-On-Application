import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/sized_config.dart';
import '../../../core/constants/screens/screen_constants.dart';

class AccountListActivityItem extends StatelessWidget {
  const AccountListActivityItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(184),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, activityDetailScreen);
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
            child: Stack(fit: StackFit.expand, children: [
              FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  child: Image.asset("assets/images/cinema.png"),
                ),
              ),
              Positioned(
                top: getProportionateScreenHeight(5),
                left: getProportionateScreenWidth(5),
                child: Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Text(
                      "Hemenal",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: getProportionateScreenHeight(0),
                child: Container(
                    child: Column(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "The Batman Filmi",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenHeight(25),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/icons/calendar_icon.png"),
                                  Text("27 ekim 18.30"),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/icons/location_icon.png"),
                                  Text("dssmak")
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: Colors.white,
                              ),
                              Text("3,7")
                            ],
                          )
                        ],
                      )
                    ]),
                    width: SizeConfig.screenWidth,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
