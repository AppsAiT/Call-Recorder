import 'dart:async';

import 'package:call_recorder/presentation/resources/assets_manager.dart';
import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:call_recorder/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _startDelay() {
    _timer = Timer(Duration(seconds: 3), _goNext);
  }

  Future<void> _goNext() async {
    PermissionStatus contactPermissionStatus =await Permission.contacts.status;
    PermissionStatus storagePermissionStatus =await Permission.storage.status;
    PermissionStatus microphonePermissionStatus =await Permission.microphone.status;
    PermissionStatus callLogPermissionStatus =await Permission.phone.status;

    if (contactPermissionStatus == PermissionStatus.granted &&
        storagePermissionStatus == PermissionStatus.granted &&
        microphonePermissionStatus == PermissionStatus.granted &&
        callLogPermissionStatus == PermissionStatus.granted) {
      Navigator.pushReplacementNamed(context, Routes.main);
    }else{
      Navigator.pushReplacementNamed(context, Routes.allowAccess);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer!.cancel();
    // TODO: implement dispose
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppStrings.callRecorder,
              style: TextStyle(
                  fontSize: FontSize.s35,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.splashTitle),
            ),
            Center(
              child: SvgPicture.asset(ImageAssets.appIc),
            ),
            Image.asset(
              ImageAssets.poweredByAppsAit,
              height: 100,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
