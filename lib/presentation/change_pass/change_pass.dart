import 'package:call_recorder/presentation/resources/assets_manager.dart';
import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:call_recorder/presentation/resources/font_manager.dart';
import 'package:call_recorder/presentation/resources/route_manager.dart';
import 'package:call_recorder/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/values_manager.dart';

class ChangePassView extends StatefulWidget {
  const ChangePassView({super.key});

  @override
  State<ChangePassView> createState() => _ChangePassViewState();
}

class _ChangePassViewState extends State<ChangePassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: AppSize.s0,
        leading: IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, Routes.passwordOptions),
            icon: SvgPicture.asset(ImageAssets.backIc)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppStrings.changePass,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorManager.darkGrey,
                    fontSize: FontSize.s35),
                textAlign: TextAlign.center,
              ),
            ),
            _getInputField(title: AppStrings.currPass),
            SizedBox(height: AppSize.s28,),
            _getInputField(title: AppStrings.newPass),
          ],
        ),
      ),
    );
  }
  Widget _getInputField({required String title}){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:AppPadding.p12,top: AppPadding.p12,),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.grey),
              )),
        ),
        TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.password),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGrey, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGrey, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGrey, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
