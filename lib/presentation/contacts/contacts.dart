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
              icon: Icon(
                Icons.search,
                color: ColorManager.darkGrey,
              ))
        ],
      ),
      
      body:AlphabetScrollPage([
          Contact(name: "John Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Aohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Gohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Hohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Hohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Hohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Bohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Mohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Sohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Qohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Yohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Zohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Eohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),
          Contact(name: "Fohn Wick", mob: "123456789", Tag: "J", imagePath: "assets/images/splash_logo.png"),

        ],(contact){
        final snackBar = SnackBar(content: Text('Clicked Item ${contact.name}',style: TextStyle(fontSize: 20),));
        ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(snackBar);
      })
    );
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
      Divider(thickness: AppSize.s1_5,),
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
        trailing: Icon(Icons.call_outlined),
      ),

    ],
  );
}

Widget _getPopupMenu(BuildContext context) {
  return IconButton(
    icon: SvgPicture.asset(ImageAssets.menuIc),
    color: ColorManager.white,
    onPressed: () {
      Navigator.pushReplacementNamed(context, Routes.menuPage);
  },

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
