import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:call_recorder/presentation/resources/font_manager.dart';
import 'package:call_recorder/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../resources/assets_manager.dart';
import '../resources/route_manager.dart';
import '../resources/values_manager.dart';

class AllowAccessView extends StatefulWidget {
  const AllowAccessView({super.key});

  @override
  State<AllowAccessView> createState() => _AllowAccessViewState();
}

class _AllowAccessViewState extends State<AllowAccessView> {
  late final List<Widget> _list = _getSliderData();
  int _currentIndex = 0;

  List<Widget> _getSliderData() {
    return [
      _getAllowAccessDialog(context,
          allowBtnAction: _getRunInBackgroundPermission,
          denyButtonAction: denyButtonAction,
          title: AppStrings.ribTitle,
          message: AppStrings.ribMessage),
      _getAllowAccessDialog(context,
          allowBtnAction: _getContactPermission,
          denyButtonAction: denyButtonAction,
          title: AppStrings.carTitle,
          message: AppStrings.carMessage),
      _getAllowAccessDialog(context,
          allowBtnAction: _getCallLogPermission,
          denyButtonAction: denyButtonAction,
          title: AppStrings.clrTitle,
          message: AppStrings.clrMessage),
      _getAllowAccessDialog(context,
          allowBtnAction: _getMicrophonePermission,
          denyButtonAction: denyButtonAction,
          title: AppStrings.mrTitle,
          message: AppStrings.mrMessage),
      _getAllowAccessDialog(context,
          allowBtnAction: _getStoragePermission,
          denyButtonAction: denyButtonAction,
          title: AppStrings.srTitle,
          message: AppStrings.srMessage),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: _list.elementAt(_currentIndex),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _list.length; i++)
                  Padding(
                    padding: EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i, _currentIndex),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  void allowButtonAction() {
    _getContactPermission();
  }

  void denyButtonAction() {
    Navigator.pushReplacementNamed(context, Routes.splashRoute);
  }

  Widget _getAllowAccessDialog(BuildContext context,
      {required VoidCallback allowBtnAction,
      required VoidCallback denyButtonAction,
      required String title,
      required String message}) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s28)),
        color: Colors.black.withOpacity(0.3),
        shadowColor: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p12,
              right: AppPadding.p12,
              top: AppPadding.p30,
              bottom: AppPadding.p12),
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.4,
            // width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: FontSize.s20),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.normal,
                    fontSize: FontSize.s16,
                  ),
                ),
                SizedBox(
                  height: AppSize.s40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 38,
                      width: 150,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xfffbb9b5), Color(0xfff55145)],
                            stops: [0, 1],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(60),
                          // boxShadow: <BoxShadow>[
                          //   BoxShadow(
                          //       color: Color.fromRGBO(0, 0, 0, 0.57),
                          //       //shadow for button
                          //       blurRadius: 5) //blur radius of shadow
                          // ]
                        ),
                        child: ElevatedButton(
                          onPressed: allowBtnAction,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: AppPadding.p30, right: AppPadding.p30),
                            child: Text(
                              AppStrings.allow,
                              style: TextStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Deny Button
                    ElevatedButton(
                      onPressed: denyButtonAction,
                      style: ElevatedButton.styleFrom(
                          elevation: 20,
                          backgroundColor: Colors.white,
                          disabledForegroundColor: Colors.white,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(180))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppPadding.p8,
                            bottom: AppPadding.p8,
                            left: AppPadding.p40,
                            right: AppPadding.p40),
                        child: Text(
                          AppStrings.deny,
                          style: TextStyle(
                              color: Colors.black, fontSize: FontSize.s16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (tee) {},
                    ),
                    Text(
                      AppStrings.dant,
                      style: TextStyle(color: ColorManager.white),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.darkCicle); //Selected Slider
    } else {
      return SvgPicture.asset(ImageAssets.lightCicle); //Selected Slider
    }
  }

  //Check Run in background permission
  Future<bool> _getRunInBackgroundPermission() async {
    bool reqPermission = await FlutterBackground.initialize();

    bool hasPermissions = await FlutterBackground.hasPermissions;
    if (hasPermissions) {
      setState(() {
        goNext();
      });
    } else {
      Navigator.pushReplacementNamed(context, Routes.splashRoute);
    }
    return hasPermissions;
  }

//Check contacts permission
  Future<PermissionStatus> _getContactPermission() async {
    // final PermissionStatus permission = await Permission.contacts.status;

    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      setState(() {
        goNext();
      });
      return Permission.contacts.status;
    } else if (await Permission.contacts.request().isDenied) {
      Navigator.pushReplacementNamed(context, Routes.splashRoute);
      return Permission.contacts.status;
    }
    return Permission.contacts.status;
  }

  //Check Call Log permission
  Future<PermissionStatus> _getCallLogPermission() async {
    // final PermissionStatus permission = await Permission.contacts.status;

    if (await Permission.phone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      setState(() {
        goNext();
      });
      return Permission.phone.status;
    } else if (await Permission.phone.request().isDenied) {
      Navigator.pushReplacementNamed(context, Routes.splashRoute);
      return Permission.phone.status;
    }
    return Permission.phone.status;
  }

  //Check Microphone permission
  Future<PermissionStatus> _getMicrophonePermission() async {
    // final PermissionStatus permission = await Permission.contacts.status;

    if (await Permission.microphone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      setState(() {
        goNext();
      });
      return Permission.microphone.status;
    } else if (await Permission.microphone.request().isDenied) {
      Navigator.pushReplacementNamed(context, Routes.splashRoute);
      return Permission.microphone.status;
    }
    return Permission.microphone.status;
  }

  //Check Storage permission
  Future<PermissionStatus> _getStoragePermission() async {
    // final PermissionStatus permission = await Permission.contacts.status;

    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      setState(() {
        Navigator.pushReplacementNamed(context, Routes.main);
      });
      return Permission.storage.status;
    } else if (await Permission.storage.request().isDenied) {
      Navigator.pushReplacementNamed(context, Routes.splashRoute);
      return Permission.storage.status;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      if (await Permission.mediaLibrary.request().isGranted) {
        setState(() {
          Navigator.pushReplacementNamed(context, Routes.main);
        });
      } else if (await Permission.mediaLibrary.request().isDenied) {
        // Navigator.pushReplacementNamed(context, Routes.splashRoute);
      }
    }
    return Permission.storage.status;
  }

  int goNext() {
    // TODO: implement goNext
    _currentIndex++;

    return _currentIndex;
  }

  int goPrevious() {
    _currentIndex--;

    return _currentIndex;
  }

  void onPageChanged(int index) {
    _currentIndex = index;
  }
}
