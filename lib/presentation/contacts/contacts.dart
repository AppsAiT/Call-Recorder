import 'package:call_recorder/presentation/contacts/AlphabetScrollPage.dart';
import 'package:call_recorder/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import 'package:azlistview/azlistview.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
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
            AppStrings.contacts,
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
          actions: [
            // Navigate to the Search Screen
            IconButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, Routes.searchPage),
              icon: SvgPicture.asset(ImageAssets.searchIc),
            ),
          ],
        ),
        body: AlphabetScrollPage([
          Contact(
              name: "John Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Aohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Gohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Hohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Hohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Hohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Bohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Mohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Sohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Qohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Yohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Zohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Eohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
          Contact(
              name: "Fohn Wick",
              mob: "123456789",
              Tag: "J",
              imagePath: "assets/images/splash_logo.png"),
        ], (contact) {
          final snackBar = SnackBar(
              content: Text(
            'Clicked Item ${contact.name}',
            style: TextStyle(fontSize: 20),
          ));
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        }));
  }
}

// ListView(children: [
// _getContactCard(context, image: AssetImage("assets/images/splash_logo.png"), name: "John Wick", contactNumber: "123567890"),
// _getContactCard(context, image: AssetImage("assets/images/splash_logo.png"), name: "John Wick", contactNumber: "123567890"),
// _getContactCard(context, image: AssetImage("assets/images/splash_logo.png"), name: "John Wick", contactNumber: "123567890"),
// _getContactCard(context, image: AssetImage("assets/images/splash_logo.png"), name: "John Wick", contactNumber: "123567890"),
// ],)

Widget _getContactCard(context,
    {required AssetImage image,
    required String name,
    required String contactNumber}) {
  return Column(
    children: [
      Divider(
        thickness: AppSize.s1_5,
      ),
      ListTile(
        leading: CircleAvatar(
          maxRadius: AppSize.s28,
          minRadius: AppSize.s20,
          //radius: AppSize.s28,
          backgroundImage: image,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: AppPadding.p8),
          child: Text(
            name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        subtitle: Text(
          contactNumber,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: SvgPicture.asset(ImageAssets.callDarkIc),
      ),
    ],
  );
}

Widget _getPopupMenu(BuildContext context) {
  return
      PopupMenuButton<int>(
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

void menuHandler(int value) {
  switch (value) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
  }
}
