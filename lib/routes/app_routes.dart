import 'package:flutter/material.dart';
import 'package:mvvm_example/users_list/views/home_screen.dart';
import 'package:mvvm_example/users_list/views/repos_webview.dart';
import 'package:mvvm_example/users_list/views/user_details_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String user_details = '/user-details';
  static const String webview = '/web-view';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(MyHomePage(), settings);
      
      case user_details:
        return _buildRoute(UserDetailScreen(), settings);

      case webview:
        return _buildRoute(ReposWebView(), settings);

      default:
        return _buildRoute(Scaffold(), settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

