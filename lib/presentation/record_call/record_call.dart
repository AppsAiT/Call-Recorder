import 'package:call_recorder/presentation/record_call/record_call_playing.dart';
import 'package:call_recorder/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

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

  List<Widget> _getCallRecordPages() => [
    _getRecordCallScr(),
    _getCallRecPlayingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 90,
          decoration: const BoxDecoration(

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
          style: Theme.of(context).textTheme.displayLarge,
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

  Widget _pageLoader(int index){
     switch(index){
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

  Widget _getCallRecPlayingScreen(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        Padding(
          padding: const EdgeInsets.only(top:AppPadding.p8,bottom: AppPadding.p40,),
          child: Column(
            children: [
              Text("00 : 52 : 12",style: TextStyle(fontSize: FontSize.s27,color: Colors.black),),
              SizedBox(height: AppSize.s16,),
              Text("Jason Williams",style: TextStyle(fontSize: FontSize.s27),),
              Text("1234567890",style: TextStyle(fontSize: FontSize.s16,color: Colors.grey),),
            ],
          ),
        ),

        SizedBox(height: 50,),

        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p40,bottom: AppPadding.p40,left: AppPadding.p8,right: AppPadding.p8),
          child: SvgPicture.asset(ImageAssets.recPlayingBack,width: MediaQuery.of(context).size.width,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){}, icon:  SvgPicture.asset(ImageAssets.pause1Ic),iconSize: 70.0,style: IconButton.styleFrom(elevation: AppSize.s4),),
              IconButton(onPressed: (){
                setState(() {
                  _pageController.jumpToPage(0);
                  _currentIndex--;
                });
              }, icon:  SvgPicture.asset(ImageAssets.stop1Ic),iconSize: 100,)

          ],),
        ),
      ],);
  }

  Widget _getRecordCallScr(){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            InkWell(
                onTap: () => setState(() {
                  _pageController.jumpToPage(1);
                  _currentIndex++;
                }),
                // onTap: () => Navigator.pushReplacementNamed(
                //     context, Routes.callRecPlaying),
                child: SvgPicture.asset(
                  ImageAssets.recordIc,
                )),
            SvgPicture.asset(
              ImageAssets.soundDotLarge,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
        Text(
          AppStrings.startRecording,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }

  Widget _getPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      icon: SvgPicture.asset(ImageAssets.menuIc),
      itemBuilder: (context) => [
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyLarge,
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
