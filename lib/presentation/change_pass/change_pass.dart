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
        leading: IconButton(onPressed: () =>
            Navigator.pushReplacementNamed(context, Routes.passwordOptions),
            icon: SvgPicture.asset(ImageAssets.backIc)),
      ),
      body: Column(children: [
        
        Text(AppStrings.changePass,style: TextStyle(fontWeight: FontWeight.w500,color: ColorManager.darkGrey,fontSize: FontSize.s16),)
      ],),
    );
  }
}
