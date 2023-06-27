import 'package:call_recorder/presentation/call_history/call_history.dart';
import 'package:call_recorder/presentation/contacts/contacts.dart';
import 'package:call_recorder/presentation/rec_history/rec_history.dart';
import 'package:call_recorder/presentation/record/record.dart';
import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:call_recorder/presentation/resources/strings_manager.dart';
import 'package:call_recorder/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  late final List<Widget> _list = _getSliderData();

  List<Widget> _getSliderData() =>
      [
       ContactsView(),
       RecordView(),
       CallHistoryView(),
       RecHistoryView()
      ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: _list.elementAt(_currentIndex),

      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }


  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageAssets.contactInactiveIc),
          label: AppStrings.contacts,
          backgroundColor: ColorManager.white),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageAssets.recordInactiveSmallIc,height: AppSize.s16,width: AppSize.s16,color: ColorManager.grey,),
          label: AppStrings.record,
          backgroundColor: ColorManager.white),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageAssets.callHistoryInactiveIc),
          label: AppStrings.callHistory,
          backgroundColor: ColorManager.white),
      BottomNavigationBarItem(icon: SvgPicture.asset(ImageAssets.contactInactiveIc),
          label: AppStrings.recordingHistory,
          backgroundColor: ColorManager.white),

    ],
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,

    unselectedItemColor: ColorManager.darkGrey,
    showSelectedLabels: false,
    selectedIconTheme: IconThemeData(color: ColorManager.primary),
    selectedItemColor: Colors.red,
    iconSize: AppSize.s20,
    onTap: _onItemTapped,
    elevation: AppSize.s4,);
  }

}
class SliderObject{
  // Data Class
  String title;
  
  SliderObject(this.title);
}
