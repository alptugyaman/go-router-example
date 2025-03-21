import 'package:flutter/material.dart';

/// Singleton class to manage a global [RouteObserver]
class RouteObserverManager {
  RouteObserverManager._();

  /// A singleton [RouteObserver] instance that can be used for route-aware widgets
  static final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();
}

/// Observer that logs all navigation events
class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      '[GoRouter]: Pushed ${route.settings.name} from ${previousRoute?.settings.name}',
    );

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      '[GoRouter]: Popped ${route.settings.name} back to ${previousRoute?.settings.name}',
    );

    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('[GoRouter]: Removed ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
      '[GoRouter]: Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
