import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';


class CallRecPlayView extends StatefulWidget {
  const CallRecPlayView({super.key});

  @override
  State<CallRecPlayView> createState() => _CallRecPlayViewState();
}

class _CallRecPlayViewState extends State<CallRecPlayView> {
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

      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(ImageAssets.recordIc,),
              SvgPicture.asset(ImageAssets.soundWaveBack,height: 200,width: MediaQuery.of(context).size.width,),
            ],),
          Text("Hey You Reached",style: Theme.of(context).textTheme.bodyLarge,)
        ],),
    );
  }
  Widget _getPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      icon: SvgPicture.asset(ImageAssets.menuIc),
      itemBuilder: (context) =>[
        _getMenuItem(context,value:0,route: Routes.changePass, leadingIcon: ImageAssets.passwordIc, trailingIcon: ImageAssets.arrowRight, title: AppStrings.password, subTitle: AppStrings.passwordSub),
        _getMenuItem(context,value:1,route: Routes.changePass, leadingIcon: ImageAssets.aboutIc, trailingIcon: ImageAssets.arrowRight, title: AppStrings.about, subTitle: AppStrings.aboutSub),
        _getMenuItem(context,value:2,route: Routes.changePass, leadingIcon: ImageAssets.policyIc, trailingIcon: ImageAssets.arrowRight, title: AppStrings.privacyPolicy, subTitle: AppStrings.privacyPolicySub),
      ],
    );


  }

  PopupMenuItem<int> _getMenuItem(
      BuildContext context,
      { required int value,
        required String route,
        required String leadingIcon,
        required String trailingIcon,
        required String title,
        required String subTitle}) {
    return PopupMenuItem(
      value: value,
      child: ListTile(
        leading:Padding(
          padding: const EdgeInsets.only(left: AppPadding.p8),
          child: SvgPicture.asset(leadingIcon,alignment: Alignment.center,height: AppSize.s28,width: AppSize.s28,),
        ),
        title: Text(title,style: Theme.of(context).textTheme.titleLarge,),
        subtitle: Text(subTitle,style: Theme.of(context).textTheme.bodyLarge,),
        trailing:Padding(
          padding: const EdgeInsets.only(right: AppPadding.p8),
          child: SvgPicture.asset(trailingIcon),
        ),
        onTap: (){
          Navigator.pushReplacementNamed(context, route);
        },
      ),
    );
  }
  }

