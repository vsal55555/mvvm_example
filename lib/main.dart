import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvvm_example/routes/app_routes.dart';
import 'package:mvvm_example/users_list/view_models/github_view_model.dart';
import 'package:mvvm_example/users_list/views/home_screen.dart';
import 'package:mvvm_example/users_list/views/localization_service.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //wrap materialApp with provider widget
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GitHubViewModel>(
      create: (_) => GitHubViewModel(),
      child: GetMaterialApp(
        title: 'MVVM',
        translations: LocalizationService(),
        locale: LocalizationService().getCurrentLocale(),//Locale('en', 'Us'),
        fallbackLocale: Locale('en', 'US'),
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
       // home: const MyHomePage(),
      ),
    );
  }
}



/*
 return MultiProvider(providers: [
      ChangeNotifierProvider<UsersViewModel>(create: (_) => UsersViewModel())//we have only one provider class in our case.
    ],
      child: MaterialApp(
 */