import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class AutoRecordView extends StatefulWidget {
  const AutoRecordView({super.key});

  @override
  State<AutoRecordView> createState() => _AutoRecordViewState();
}

class _AutoRecordViewState extends State<AutoRecordView> {
  bool _autoRecStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            backgroundBlendMode: BlendMode.multiply,
            gradient: LinearGradient(
              colors: [Color(0xffffffff), Color(0xfff8b8cd)],
              stops: [0.1, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSize.s28),
            bottomRight: Radius.circular(AppSize.s28),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.settings);
          },
          icon: SvgPicture.asset(ImageAssets.backIc),
        ),
        title: Text(
          AppStrings.autoRecord,
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

      body: Padding(padding:  EdgeInsets.only(
          top: AppPadding.p40,
          bottom: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12),
      child: ListView(children: [
          _getAutoRecording(),
      ],),),
    );
  }


  Widget _getAutoRecording() {
    return Column(
      children: [
        ListTile(
          title: Text(
            AppStrings.automaticRecording,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: AppPadding.p8),
            child: CupertinoSwitch(
                thumbColor: _autoRecStatus == true ? ColorManager.primary:ColorManager.grey,
                activeColor: ColorManager.lightBlue,
                // trackColor: ColorManager.primaryOpacity70,
                value: _autoRecStatus,
                onChanged: (value) {
                  setState(() {
                    _autoRecStatus = value;
                  });
                }),
          ),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
