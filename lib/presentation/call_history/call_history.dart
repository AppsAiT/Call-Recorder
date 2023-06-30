import 'dart:async';

import 'package:azlistview/azlistview.dart';
import 'package:call_recorder/presentation/call_history/date_scroll_page.dart';
import 'package:call_recorder/presentation/call_history/incoming_call_list.dart';
import 'package:call_recorder/presentation/call_history/missed_call_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../contacts/contacts.dart';
import '../record_audio/record_audio.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import 'outgoing_call_list.dart';

class CallHistoryView extends StatefulWidget {
   CallHistoryView({super.key});
  // List<ContactHistory> _contactList = [];
  @override
  State<CallHistoryView> createState() => _CallHistoryViewState();
}

class _CallHistoryViewState extends State<CallHistoryView> {
  List<ContactHistory> _contactList = _getContactHistory();

  int _currentIndex = 0;

  StreamController<List<ContactHistory>> _streamController= StreamController<List<ContactHistory>>();
  StreamSink<List<ContactHistory>> get _sink => _streamController.sink;
  Stream<List<ContactHistory>> get _stream => _streamController.stream;
  late final List<Widget> _categoryList = _getSliderData();
  


  List<Widget> _getSliderData() {
    CallList callList = CallList(contactList: _contactList);
    return  [

      DateScrollPage(_contactList, (value) { }),
      IncomingCallList(callList._incomingList(), (value) { }),
      OutgoingCallList(callList._outgoingList(), (value) { }),
      MissedCallList(callList._missedList(), (value) { }),

    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xfff8b8cd)],
                stops: [0.3, 1],
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
          AppStrings.callHistory,
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
        actions: [
          // Navigate to the Search Screen
          IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, Routes.searchPage),
            icon: SvgPicture.asset(ImageAssets.searchIc),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: Column(
              children: [
              _getCategoryTab(),
          _categoryList.elementAt(_currentIndex),
          //*****************
      ],
    ),),
      bottomNavigationBar: SizedBox(height: 50,),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
      // List<ContactHistory> _postList = [];
      // switch(index){
      //   case 0:
      //     _streamController.add(_contactList);
      //     break;
      //   case 1:
      //     for(int i =0; i<_contactList.length;i++){
      //       if(_contactList[i].category == "incoming"){
      //         _postList.add(_contactList[index]);
      //       }
      //     }
      //     _streamController.add(_postList);
      //     break;
      //
      // }

  }

  Widget _getCategoryTab() {
    return Padding(
      padding: const EdgeInsets.only(
          right: AppPadding.p20, left: AppPadding.p20),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          //unselectedItemColor: ColorManager.darkGrey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          //selectedIconTheme: IconThemeData(color: ColorManager.primary),
          // selectedItemColor: Colors.red,
          iconSize: AppSize.s20,
          onTap: _onItemTapped,
          elevation: AppSize.s0,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.cat1Inactive),
                activeIcon: SvgPicture.asset(ImageAssets.cat1Active),
                label: AppStrings.contacts,
                backgroundColor: ColorManager.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.cat2Inactive),
                activeIcon: SvgPicture.asset(ImageAssets.cat2Active),
                label: AppStrings.record,
                backgroundColor: ColorManager.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.cat3Inactive),
                activeIcon: SvgPicture.asset(ImageAssets.cat3Active),
                label: AppStrings.recordingHistory,
                backgroundColor: ColorManager.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssets.cat4Inactive),
                activeIcon: SvgPicture.asset(ImageAssets.cat4Active),
                label: AppStrings.recordingHistory,
                backgroundColor: ColorManager.white),
          ]),
    );
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

  void menuHandler(int value) {
    switch (value) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}
  List<ContactHistory> _getContactHistory() =>[
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "05-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "08-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "02-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "17-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "08-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "02-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "02-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "07-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "05-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "07-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "09-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "11-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "11-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "21-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "21-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "31-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John outgoing", mob: "0123456789", category: "outgoing", tag: "09-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "11-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "08-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John incoming", mob: "0123456789", category: "incoming", tag: "01-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "05-02-2023", imagePath: "assets/images/app_ic.png"),
    ContactHistory(name: "John missed", mob: "0123456789", category: "missed", tag: "31-02-2023", imagePath: "assets/images/app_ic.png"),
  ];

class CallList{
  List<ContactHistory> contactList;
  List<ContactHistory> _incList = [];
  List<ContactHistory> _outList = [];
  List<ContactHistory> _misList = [];
  CallList({required this.contactList });

  List<ContactHistory> _incomingList(){
    _incList.clear();
    for(int i =0; i<contactList.length;i++){
      if(contactList[i].category == "incoming"){
        _incList.add(contactList[i]);
      }
    }
    return _incList;
  }

  List<ContactHistory> _outgoingList(){
    _outList.clear();
    for(int i =0; i<contactList.length;i++){
      if(contactList[i].category == "outgoing"){
        _outList.add(contactList[i]);
      }
    }
    return _outList;
  }

  List<ContactHistory> _missedList(){
    _outList.clear();
    for(int i =0; i<contactList.length;i++){
      if(contactList[i].category == "missed"){
        _outList.add(contactList[i]);
      }
    }
    return _outList;
  }
}

