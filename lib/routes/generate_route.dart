import 'package:flutter/material.dart';
import 'package:taskmanagement/views/task_screen.dart';

class Routes {
  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => TaskScreen());
    }
    return MaterialPageRoute(builder: (context) => TaskScreen());
  }
}
