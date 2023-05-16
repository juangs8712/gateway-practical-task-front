import 'package:flutter/cupertino.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // -----------------------------------------------------
  static navigateTo(String routeName, { Object? arguments }) {
    return navigatorKey.currentState!
      .pushNamed( routeName, arguments: arguments);
  }
  // -----------------------------------------------------
  static replaceTo(String routeName, { Object? arguments }) {
    return navigatorKey.currentState!
      .pushReplacementNamed( routeName, arguments: arguments );
  }
  // -----------------------------------------------------
  static pop(){
    return navigatorKey.currentState!.pop();
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

