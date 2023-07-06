

import 'package:call_recorder/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:record/record.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class RecordCallView extends StatefulWidget {
  const RecordCallView({super.key});

  @override
  State<RecordCallView> createState() => _RecordCallViewState();
}

class _RecordCallViewState extends State<RecordCallView> {
  late final List<Widget> _list = _getCallRecordPages();
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  final Record record = Record();
  final FlutterSoundRecorder _flutterSoundRecorder = FlutterSoundRecorder();

  List<Widget> _getCallRecordPages() =>
      [
        _getRecordCallScr(),
        _getCallRecPlayingScreen(),
      ];

  void setStream() {
    PhoneState.phoneStateStream.listen((event) {
      setState(() {
        if (event != null) {
          status = event;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setStream();
    _flutterSoundRecorder.openRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          // padding: EdgeInsets.only(bottom: AppPadding.p8),
          // clipBehavior: Clip.none,
          height: double.infinity,
          decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.multiply,
              //color: Colors.transparent,
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xfff8b8cd)],
                stops: [0.1, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.s28),
                bottomRight: Radius.circular(AppSize.s28))),
        leading: _getPopupMenu(context),
        title: Text(
          AppStrings.recordCall,
          style: Theme
              .of(context)
              .textTheme
              .displayLarge,
          textAlign: TextAlign.center,
        ),
        backgroundColor: ColorManager.white,
        elevation: AppSize.s4,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        // actions: [
        //   // Navigate to the Search Screen
        //   IconButton(
        //     onPressed: () =>
        //         Navigator.pushReplacementNamed(context, Routes.searchPage),
        //     icon: SvgPicture.asset(ImageAssets.searchIc),
        //   ),
        // ],
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _list.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return _pageLoader(index);
          }),
    );
  }

  Widget _pageLoader(int index) {
    switch (index) {
      case 0:
        return _getRecordCallScr();
        break;
      case 1:
        return _getCallRecPlayingScreen();
        break;
      default:
        return Container();
    }
  }

  Widget _getCallRecPlayingScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p8,
            bottom: AppPadding.p40,
          ),
          child: Column(
            children: [
              Text(
                "00 : 52 : 12",
                style: TextStyle(fontSize: FontSize.s27, color: Colors.black),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Text(
                "Jason Williams",
                style: TextStyle(fontSize: FontSize.s27),
              ),
              Text(
                "1234567890",
                style: TextStyle(fontSize: FontSize.s16, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.p40,
              bottom: AppPadding.p40,
              left: AppPadding.p8,
              right: AppPadding.p8),
          child: SvgPicture.asset(
            ImageAssets.recPlayingBack,
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(ImageAssets.pause1Ic),
                iconSize: 70.0,
                style: IconButton.styleFrom(elevation: AppSize.s4),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _pageController.jumpToPage(0);
                    _currentIndex--;
                  });
                },
                icon: SvgPicture.asset(ImageAssets.stop1Ic),
                iconSize: 100,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _getRecordCallScr() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
                height: AppSize.s130,
                width: AppSize.s130,
                child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: _startCallRecord,
                      child: SvgPicture.asset(
                        ImageAssets.mic2WhiteIc,
                        height: AppSize.s20,
                        width: AppSize.s20,
                      ),
                      backgroundColor: Colors.blue,
                    ))),
            SvgPicture.asset(
              ImageAssets.soundDotLarge,
              height: 200,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
          ],
        ),
        Text(
          AppStrings.startRecording,
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        )
      ],
    );
  }

  Future<void> _startCallRecord() async {
    PermissionStatus phoneState = await Permission.phone.status;


    if (phoneState.isGranted) {
      setStream();

      if (status == PhoneStateStatus.CALL_STARTED) {
        _flutterSoundRecorder.startRecorder(
            toFile: '/storage/emulated/0/Download/myFile.wav',
            codec: Codec.pcm16WAV,);
        if (await record.hasPermission()) {
          // Start recording
          // await record.start(
          //   path: '/storage/emulated/0/Download/myFile.m4a',
          //   encoder: AudioEncoder.aacLc, // by default
          //   bitRate: 128000, // by default
          //   samplingRate: 44100, // by default
          //
          // ); Fluttertoast.showToast(
          //   msg: "Recording HAs been Started",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        }
      }
    } else {
      await Permission.phone.request();
    }
    Future.delayed(Duration(seconds: 30), () async => await record.stop());
    Future.delayed(Duration(seconds: 30), () async =>
        _flutterSoundRecorder.stopRecorder());
  }

  Widget _getPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      icon: SvgPicture.asset(ImageAssets.menuIc),
      itemBuilder: (context) =>
      [
        _getMenuItem(context,
            value: 0,
            route: Routes.changePass,
            leadingIcon: ImageAssets.passwordIc,
            trailingIcon: ImageAssets.arrowRight,
            title: AppStrings.password,
            subTitle: AppStrings.passwordSub),
        _getMenuItem(context,
            value: 1,
            route: Routes.changePass,
            leadingIcon: ImageAssets.aboutIc,
            trailingIcon: ImageAssets.arrowRight,
            title: AppStrings.about,
            subTitle: AppStrings.aboutSub),
        _getMenuItem(context,
            value: 2,
            route: Routes.changePass,
            leadingIcon: ImageAssets.policyIc,
            trailingIcon: ImageAssets.arrowRight,
            title: AppStrings.privacyPolicy,
            subTitle: AppStrings.privacyPolicySub),
      ],
    );
  }

  PopupMenuItem<int> _getMenuItem(BuildContext context,
      {required int value,
        required String route,
        required String leadingIcon,
        required String trailingIcon,
        required String title,
        required String subTitle}) {
    return PopupMenuItem(
      value: value,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p8),
          child: SvgPicture.asset(
            leadingIcon,
            alignment: Alignment.center,
            height: AppSize.s28,
            width: AppSize.s28,
          ),
        ),
        title: Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
        subtitle: Text(
          subTitle,
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: AppPadding.p8),
          child: SvgPicture.asset(trailingIcon),
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, route);
        },
      ),
    );
  }
}
