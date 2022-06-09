import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/data/models/user_model.dart';
import 'package:flutter_group_on/screens/add_activity_screen/blocs/add_activity_bloc.dart';
import 'package:flutter_group_on/screens/add_activity_screen/model/add_activity_model.dart';
import 'package:flutter_group_on/screens/add_activity_screen/view/search_maps_screen.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../core/config/sized_config.dart';
import '../../../data/components/background.dart';

String selectedImageUrl = "";

class AddActivityScreen extends StatelessWidget {
  AddActivityScreen({Key? key}) : super(key: key);
  TextEditingController activityNameController = TextEditingController();
  TextEditingController activityDeclarationController = TextEditingController();
  TextEditingController activityLimitController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typesController = TextEditingController();
  TextEditingController activityTimeController = TextEditingController();

  List<String> types = ["Oyun", "Eğlence", "Gezi", "Eğitim"];
  List<String> imageUrls = [
    "https://www.bizevdeyokuz.com/wp-content/uploads/cumbali-cafe-balat.jpg",
    "https://www.neredekal.com/res/blog/1602760853_ana_gorseljpg.jpeg",
    "https://media-cdn.tripadvisor.com/media/photo-s/08/97/27/16/cinema-rex.jpg",
    "https://media.istockphoto.com/photos/cheering-crowd-of-unrecognized-people-at-a-rock-music-concert-concert-picture-id1189205501?k=20&m=1189205501&s=612x612&w=0&h=fexl_Cmu6AdLatIasGg_XYTkLSeWHCtvhMw1nK5_uDc="
  ];
  List<String> selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => AddActivityCubit(AddActivityState.initial),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
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
        Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(15)),
                      child: PhotoContainerComponent(
                        imageUrls: this.imageUrls,
                      )),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Container(
                    height: 2 * 24.0,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: activityNameController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Aktivite Adı",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Container(
                    height: 5 * 24.0,
                    child: TextField(
                      controller: activityDeclarationController,
                      style: TextStyle(color: Colors.white),
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Aktivite Açıklaması",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Container(
                    height: 2 * 24.0,
                    child: TextField(
                      maxLines: 1,
                      controller: locationController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: IconButton(
                            icon: Image.asset("assets/icons/location_icon.png"),
                            onPressed: () async {
                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPlacesScreen(),
                                  ));
                              // print(result.position.latitude);
                              locationController.text =
                                  "Lat :${result.position.latitude.toString().substring(0, 5)}  Long:${result.position.longitude.toString().substring(0, 5)}";
                            },
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Lokasyon",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          print("sa");
                          await showDialog(
                              context: context,
                              builder: (ctx) {
                                return MultiSelectDialog(
                                  selectedItemsTextStyle:
                                      TextStyle(color: Colors.white),
                                  unselectedColor: Colors.white,
                                  checkColor: Colors.white,
                                  itemsTextStyle:
                                      TextStyle(color: Colors.white),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  height: SizeConfig.screenHeight / 4,
                                  items: types
                                      .map((types) =>
                                          MultiSelectItem(types, types))
                                      .toList(),
                                  title: Text(
                                    "Türler",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  selectedColor: Colors.blue,
                                  onConfirm: (results) {
                                    String savetypes = " ";
                                    // print(results);
                                    selectedTypes = results as List<String>;
                                    results.forEach((e) {
                                      savetypes += "$e,";
                                    });
                                    print(savetypes);
                                    typesController.text = savetypes;
                                  },
                                  initialValue: selectedTypes,
                                );
                              });
                        },
                        child: Container(
                          width: SizeConfig.screenWidth * 1 / 3,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Expanded(
                                child: IgnorePointer(
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    controller: typesController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'Tür Ekle',
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 1 / 3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(5),
                            ),
                            Icon(
                              Icons.group,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(5),
                            ),
                            Expanded(
                              child: TextField(
                                controller: activityLimitController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'kişi Sayısı',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var activityTime = "";
                          DateTime? currentValue = null;
                          print("sa");
                          var date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));

                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            activityTime = date.toString().split(" ")[0] +
                                " " +
                                time!.hour.toString() +
                                ":" +
                                time!.minute.toString();
                            activityTimeController.text = activityTime;
                            print(activityTime);
                          }
                        },
                        child: Container(
                          width: SizeConfig.screenWidth * 1 / 3,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Image.asset("assets/icons/calendar_icon.png"),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Expanded(
                                child: IgnorePointer(
                                  child: TextField(
                                    controller: activityTimeController,
                                    readOnly: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'Etkinlik takvimi',
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  BlocBuilder<AddActivityCubit, AddActivityState>(
                    builder: (context, state) {
                      return OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(40),
                                    vertical:
                                        getProportionateScreenHeight(20))),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff6C14A3)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          onPressed: () async {
                            await context.read<AddActivityCubit>().addActivity(
                                  AddActivityModel(
                                      userUid: AppUser().getUserUid(),
                                      activityName: activityNameController.text,
                                      userName: AppUser().getUserName(),
                                      activityDeclarition:
                                          activityDeclarationController.text,
                                      activityLocation: locationController.text,
                                      activityTime: activityTimeController.text,
                                      activityUserLimit: int.parse(
                                          activityLimitController.text),
                                      activityTypes:
                                          typesController.text.split(","),
                                      imageUrl: selectedImageUrl),
                                );
                            // Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, tabview, (route) => false);
                          },
                          child: Text(
                            "Kaydet",
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(20),
                                color: Colors.white),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}

AddImageComponent(BuildContext ctx, List<String> imageUrls) async {
  var selectedImageIndex = imageUrls.length + 1;
  await showDialog(
      context: ctx,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setState) {
          return Container(
            color: Colors.black.withOpacity(0.4),
            height: SizeConfig.screenWidth * 1 / 3,
            width: SizeConfig.screenWidth * 1 / 3,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: imageUrls.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              selectedImageIndex = index;
                              print(index);
                              setState(() {});
                            },
                            child: Card(
                              color: selectedImageIndex == index
                                  ? Colors.green
                                  : Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: ClipRRect(
                                    child: Image.network(imageUrls[index]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(40),
                                vertical: getProportionateScreenHeight(20))),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff6C14A3)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                      ),
                      onPressed: () async {
                        // print(imageUrls[selectedImageIndex]);
                        selectedImageUrl = imageUrls[selectedImageIndex];
                        Navigator.pop(ctx, imageUrls[selectedImageIndex]);
                      },
                      child: Text(
                        "Seç",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20),
                            color: Colors.white),
                      ))
                ],
              ),
            ),
          );
        });
      });
}

class PhotoContainerComponent extends StatefulWidget {
  List<String> imageUrls;
  PhotoContainerComponent({Key? key, required this.imageUrls});

  @override
  State<PhotoContainerComponent> createState() =>
      PhotoContainerComponentState(imageUrls: this.imageUrls);
}

class PhotoContainerComponentState extends State<PhotoContainerComponent> {
  List<String> imageUrls;
  PhotoContainerComponentState({Key? key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: SizeConfig.screenWidth * 1 / 4,
      height: SizeConfig.screenWidth * 1 / 4,
      child: selectedImageUrl == ""
          ? Center(
              child: IconButton(
              icon: Image.asset("assets/icons/plus.png"),
              onPressed: () async {
                await AddImageComponent(context, imageUrls);
                print(selectedImageUrl);
                setState(() {});
              },
            ))
          : GestureDetector(
              onTap: () async {
                await AddImageComponent(context, imageUrls);
                print(selectedImageUrl);
                setState(() {});
              },
              child: FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  child: Image.network(selectedImageUrl),
                ),
              ),
            ),
    );
  }
}
