import 'package:call_recorder/presentation/call_history/call_history.dart';
import 'package:call_recorder/presentation/contacts/contacts.dart';
import 'package:call_recorder/presentation/menu/menu.dart';
import 'package:call_recorder/presentation/new_pass/new_pass.dart';
import 'package:call_recorder/presentation/rec_history/rec_history.dart';
import 'package:call_recorder/presentation/record_audio/record_audio.dart';
import 'package:call_recorder/presentation/record_call/record_call_playing.dart';

import 'package:call_recorder/presentation/resources/strings_manager.dart';
import 'package:call_recorder/presentation/search/search.dart';
import 'package:call_recorder/presentation/verify_rec/verify_rec.dart';
import 'package:flutter/material.dart';

import '../change_pass/change_pass.dart';
import '../main/main.dart';
import '../record_call/record_call.dart';
import '../splash/splash.dart';


class Routes {
  static const String splashRoute = "/";
  static const String callHistory = "/callHistory";
  static const String changePass = "/changePass";
  static const String contacts = "/contacts";
  static const String main = "/main";
  static const String newPass = "/newPass";
  static const String recHistory = "/recHistory";
  static const String record = "/record";
  static const String verifyRec = "/verifyRec";
  static const String searchPage = "/searchPage";
  static const String menuPage = "/menuPage";
  static const String callRecPlaying = "/callRecPlaying";
  static const String audioRecord = "/audioRecord";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.callHistory:
        return MaterialPageRoute(builder: (_) => CallHistoryView());
      case Routes.changePass:
        return MaterialPageRoute(builder: (_) => ChangePassView());
      case Routes.contacts:
        return MaterialPageRoute(builder: (_) => ContactsView());
      case Routes.newPass:
        return MaterialPageRoute(builder: (_) => NewPassView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.recHistory:
        return MaterialPageRoute(builder: (_) => RecHistoryView());
      case Routes.record:
        return MaterialPageRoute(builder: (_) => RecordCallView());
      case Routes.verifyRec:
        return MaterialPageRoute(builder: (_) => VerifyRecView());
      case Routes.searchPage:
        return MaterialPageRoute(builder: (_) => SearchPageView());
      case Routes.menuPage:
        return MaterialPageRoute(builder: (_) => MenuView());
      case Routes.callRecPlaying:
        return MaterialPageRoute(builder: (_) => CallRecPlayView());
      case Routes.audioRecord:
        return MaterialPageRoute(builder: (_) => RecordAudioView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound),
        ),
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
