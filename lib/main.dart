// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wempro_interview_task/providers/form_provider.dart';
import 'package:wempro_interview_task/screens/form_screen.dart';
import 'package:wempro_interview_task/screens/homepage.dart';

import 'Utils/app_routes.dart';
import 'network/api_client.dart';
import 'network/api_repository.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => FormProvider(
          formRepository: FormRepository(apiClient: ApiClient()),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: FormScreen.routeName,
      routes: AppRoutes.instance.routeList,
    );
  }
}