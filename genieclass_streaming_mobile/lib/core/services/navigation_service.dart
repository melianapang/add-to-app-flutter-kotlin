import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = Provider<NavigationService>(
  (ProviderRef<NavigationService> ref) => NavigationService(),
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  void popAllAndNavigateTo(
    String route, {
    Object? arguments,
  }) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void navigateToAndReplace(
    String routeName, {
    Object? arguments,
  }) {
    navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateTo(
    String routeName, {
    Object? arguments,
    bool alwaysPush = false,
  }) async {
    if (alwaysPush) {
      return await navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: arguments,
      );
    }

    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) =>
          !(route.isCurrent && route.settings.name == routeName),
      arguments: arguments,
    );
  }

  void navigateToRoute(Route<dynamic> route) {
    navigatorKey.currentState!.push(route);
  }

  void navigatePopAllAndNavigateToRoute(Route<dynamic> newRoute) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      newRoute,
      (Route<dynamic> route) => false,
    );
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }
}
