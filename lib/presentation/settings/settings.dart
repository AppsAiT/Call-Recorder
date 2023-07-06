import 'package:call_recorder/presentation/resources/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _autoDeleteStatus = false;
  bool _notifyStatus = false;
  bool _flotingIconStatus = false;

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
            Navigator.pushReplacementNamed(context, Routes.main);
          },
          icon: SvgPicture.asset(ImageAssets.backIc),
        ),
        title: Text(
          AppStrings.settings,
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
        child: ListView(
          children: [
            _getSettingsItem(context,
                route: Routes.passwordOptions,
                leadingIcon: ImageAssets.passwordIc,
                trailingIcon: ImageAssets.arrowRight,
                title: AppStrings.password,
                subTitle: AppStrings.passwordSub),
            _getSettingsItem(context,
                route: Routes.themeSelction,
                leadingIcon: ImageAssets.themeIc,
                trailingIcon: ImageAssets.arrowRight,
                title: AppStrings.theme,
                subTitle: AppStrings.themeSub),
            _getSettingsItem(context,
                route: Routes.autoRecord,
                leadingIcon: ImageAssets.autoRecordIc,
                trailingIcon: ImageAssets.arrowRight,
                title: AppStrings.autoRecord,
                subTitle: AppStrings.autoRecordSub),
            _getAutoDelete(),
            _getNotifyControl(),
            _getFloatingIcon(),

            _getSettingsItem(context,
                route: Routes.changePass,
                leadingIcon: ImageAssets.aboutIc,
                trailingIcon: ImageAssets.arrowRight,
                title: AppStrings.about,
                subTitle: AppStrings.aboutSub),
            _getSettingsItem(context,
                route: Routes.changePass,
                leadingIcon: ImageAssets.policyIc,
                trailingIcon: ImageAssets.arrowRight,
                title: AppStrings.privacyPolicy,
                subTitle: AppStrings.privacyPolicySub),
          ],
        ),
      ),
    );
  }

  Widget _getSettingsItem(BuildContext context,
      {required String route,
      required String leadingIcon,
      required String trailingIcon,
      required String title,
      required String subTitle}) {
    return Column(
      children: [
        ListTile(
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
        Divider(
          thickness: 1,
        )
      ],
    );
  }

  Widget _getAutoDelete() {
    return Column(
      children: [
        ListTile(
          title: Text(
            AppStrings.autoDelete,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            AppStrings.autoDeleteSub,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: AppPadding.p8),
            child: CupertinoSwitch(
              thumbColor: _autoDeleteStatus == true ? ColorManager.primary:ColorManager.grey,
              activeColor: ColorManager.lightBlue,
                // trackColor: ColorManager.primaryOpacity70,
                value: _autoDeleteStatus,
                onChanged: (value) {
                  setState(() {
                    _autoDeleteStatus = value;
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

  Widget _getNotifyControl() {
    return Column(
      children: [
        ListTile(
          title: Text(
            AppStrings.notificationControl,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: AppPadding.p8),
            child: CupertinoSwitch(
                thumbColor: _notifyStatus == true ? ColorManager.primary:ColorManager.grey,
                activeColor: ColorManager.lightBlue,
                // trackColor: ColorManager.primaryOpacity70,
                value: _notifyStatus,
                onChanged: (value) {
                  setState(() {
                    _notifyStatus = value;
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

  Widget _getFloatingIcon() {
    return Column(
      children: [
        ListTile(
          title: Text(
            AppStrings.floatingIcon,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: AppPadding.p8),
            child: CupertinoSwitch(
                thumbColor: _flotingIconStatus == true ? ColorManager.primary:ColorManager.grey,
                activeColor: ColorManager.lightBlue,
                // trackColor: ColorManager.primaryOpacity70,
                value: _flotingIconStatus,
                onChanged: (value) {
                  setState(() {
                    _flotingIconStatus = value;
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
