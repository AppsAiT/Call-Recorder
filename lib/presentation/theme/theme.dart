import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class ThemeSelectionView extends StatefulWidget {
  const ThemeSelectionView({super.key});

  @override
  State<ThemeSelectionView> createState() => _ThemeSelectionViewState();
}

class _ThemeSelectionViewState extends State<ThemeSelectionView> {
  List<bool> isSelected = [true, false];

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
          AppStrings.theme,
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
        padding: EdgeInsets.only(
            top: AppPadding.p40,
            bottom: AppPadding.p8,
            right: AppPadding.p8,
            left: AppPadding.p8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.selectTheme,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.p8),
              child: ToggleButtons(
                // splashColor:Colors.transparent ,
                // selectedColor: Colors.transparent,
                // focusColor: Colors.transparent,
                // highlightColor: Colors.transparent,
                //tapTargetSize: MaterialTapTargetSize.values.first,
                renderBorder: false,
                isSelected: isSelected,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppPadding.p8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        SvgPicture.asset(ImageAssets.blueTheme),
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p18),
                          child: isSelected[0]
                              ? SvgPicture.asset(ImageAssets.tick)
                              : SvgPicture.asset(ImageAssets.untick),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppPadding.p8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        SvgPicture.asset(ImageAssets.redTheme),
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p18),
                          child: isSelected[1]
                              ? SvgPicture.asset(ImageAssets.tick)
                              : SvgPicture.asset(ImageAssets.untick),
                        ),
                      ],
                    ),
                  ),
                ],
                onPressed: (index) {
                  setState(() {
                    if (isSelected[0]) {
                      isSelected[0] = false;
                      isSelected[1] = true;
                    } else if (isSelected[1]) {
                      isSelected[1] = false;
                      isSelected[0] = true;
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
