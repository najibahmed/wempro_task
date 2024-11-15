import 'package:flutter/material.dart';
import 'package:wempro_interview_task/screens/form_screen.dart';
import '../screens/summury_screen.dart';


class AppRoutes {
  static AppRoutes instance = AppRoutes();

  Map<String, Widget Function(BuildContext)> routeList = {
    FormScreen.routeName: (context) => FormScreen(),
    SummaryScreen.routeName: (context) => SummaryScreen(),
  };
}
