import 'package:flutter/material.dart';
import 'package:sync_package/views/add_data.dart';
import 'package:sync_package/views/home_page.dart';

class Routes {
  static const String homepage = '/';
  static const String addDataForm = 'add_data_form';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homepage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.addDataForm:
        return MaterialPageRoute(builder: (_) => const AddForm());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
