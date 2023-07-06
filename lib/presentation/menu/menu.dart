import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: SvgPicture.asset(ImageAssets.backIc),),
      title: Text(
        AppStrings.menuTitle,
        style: Theme.of(context).textTheme.displayLarge,
        textAlign: TextAlign.center,
      ),
      backgroundColor: ColorManager.white,
      elevation: AppSize.s0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),

    ),

      body: Center(child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
        _getMenuItem(context,route: Routes.changePass, leadingIcon: ImageAssets.passwordIc, trailingIcon: ImageAssets.arrowRight, title: AppStrings.password, subTitle: AppStrings.passwordSub),
        _getMenuItem(context,route: Routes.changePass, leadingIcon: ImageAssets.aboutIc, trailingIcon: ImageAssets.arrowRight, title: AppStrings.about, subTitle: AppStrings.aboutSub),
        _getMenuItem(context,route: Routes.changePass, leadingIcon: ImageAssets.policyIc, trailingIcon: ImageAssets.arrowRight, title: AppStrings.privacyPolicy, subTitle: AppStrings.privacyPolicySub),
      ],),),

    );
  }

  Widget _getMenuItem(
      BuildContext context,
      {required String route,
        required String leadingIcon,
        required String trailingIcon,
        required String title,
        required String subTitle}) {
    return ListTile(
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
    );
  }
}
