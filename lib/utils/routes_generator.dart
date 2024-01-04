import 'package:expense_tracker/add_expense/add_expense_screen.dart';
import 'package:expense_tracker/home/home_screen.dart';
import 'package:expense_tracker/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;

    final args = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        widgetScreen = HomeScreen();
        break;
      case Routes.addExpense:
        widgetScreen = AddExpenseScreen();
        break;

      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name, page: () => widgetScreen, settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
