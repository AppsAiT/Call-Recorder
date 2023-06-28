import 'package:call_recorder/call_recorder_icons.dart';
import 'package:call_recorder/presentation/call_history/call_history.dart';
import 'package:call_recorder/presentation/contacts/contacts.dart';
import 'package:call_recorder/presentation/rec_history/rec_history.dart';
import 'package:call_recorder/presentation/record_audio/record_audio.dart';

import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:call_recorder/presentation/resources/strings_manager.dart';
import 'package:call_recorder/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../record_call/record_call.dart';
import '../resources/assets_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  late final List<Widget> _list = _getSliderData();

  List<Widget> _getSliderData() => [
        const ContactsView(),
        const RecordAudioView(),
        const CallHistoryView(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _list.elementAt(_currentIndex),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return Container(
      // height: 58,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          // colors: [Color(0xffffffff), Color(0xfff8b8cd)],
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 216, 172, 172),
          ],
          stops: [0.3, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.s28),
            topLeft: Radius.circular(AppSize.s28)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 164, 164, 164),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //     topRight: Radius.circular(AppSize.s28),
      //     topLeft: Radius.circular(AppSize.s28),
      //   ),
      child: Container(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.contactInactiveIc),
                activeIcon: SvgPicture.asset(ImageAssets.contactActiveIc),
                label: AppStrings.contacts,
                backgroundColor: ColorManager.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.recordInactiveSmallIc),
                activeIcon: SvgPicture.asset(ImageAssets.recordActiveSmallIc),
                label: AppStrings.record,
                backgroundColor: ColorManager.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.callHistoryInactiveIc),
                activeIcon: SvgPicture.asset(ImageAssets.callHistoryActiveIc),
                label: AppStrings.recordingHistory,
                backgroundColor: ColorManager.white),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: const Color.fromARGB(0, 246, 246, 246),
          // unselectedItemColor: ColorManager.darkGrey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedIconTheme: IconThemeData(color: ColorManager.primary),
          // selectedItemColor: Colors.red,
          iconSize: AppSize.s20,
          onTap: _onItemTapped,
          // elevation: AppSize.s8,
          elevation: 0,
        ),
        // ),
      ),
    );
  }
}

class SliderObject {
  // Data Class
  String title;

  SliderObject(this.title);
}
