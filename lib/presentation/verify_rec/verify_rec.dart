import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class VerifyRecView extends StatefulWidget {
  const VerifyRecView({super.key});

  @override
  State<VerifyRecView> createState() => _VerifyRecViewState();
}

class _VerifyRecViewState extends State<VerifyRecView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
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
            bottomRight: Radius.circular(AppSize.s28),
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          AppStrings.verificationRecord,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "10235624789",
                        style: TextStyle(
                            color: Colors.black, fontSize: FontSize.s20),
                      ),
                      Text(
                        "01:02:03",
                        style: TextStyle(
                            color: Colors.grey, fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p40),
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        prefix: SizedBox(
                          width: AppSize.s14,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        hintText: AppStrings.enterRecTitleHint,
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s150,),
                  //Audio Player Visuals(Replaced With Temporary Image)
                  SvgPicture.asset(ImageAssets.verfBack),
                  SizedBox(height: AppSize.s100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.restartIc),iconSize: 70,),
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.playWhiteIc),iconSize: 70,),
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.speedWhiteIc),iconSize: 70,),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.saveIc),iconSize: AppSize.s40,),
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.saveGDIc),iconSize: AppSize.s40,),
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.shareIc),iconSize: AppSize.s40,),
                      IconButton(onPressed: (){
                        setState(() {

                        });
                      }, icon:  SvgPicture.asset(ImageAssets.deleteIc),iconSize: AppSize.s40,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
