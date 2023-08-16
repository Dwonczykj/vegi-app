import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class VegiDebugRouteObserver extends AutoRouterObserver {
  /// Called when the current route has been pushed.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.verbose(
      'New route pushed: ${route.settings.name} from ${previousRoute?.settings.name}',
      stackTrace: StackTrace.current,
      dontLog: true,
    );
  }

  /// Called when the current route has been popped off.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.verbose(
      'New route popped: ${route.settings.name} to ${previousRoute?.settings.name}',
      stackTrace: StackTrace.current,
      dontLog: true,
    );
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log.verbose(
      'Tab route visited: ${route.name}',
      stackTrace: StackTrace.current,
      dontLog: true,
    );
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log.verbose(
      'Tab route re-visited: ${route.name}',
      stackTrace: StackTrace.current,
      dontLog: true,
    );
  }
}

class RootRouterLogger extends RootRouter {
  RootRouterLogger({required AuthGuard authGuard})
      : super();

  @override
  Future<T?> push<T extends Object?>(PageRouteInfo<dynamic> route,
      {void Function(NavigationFailure)? onFailure,}) {
    final filteredStack = StackTrace.current.filterCallStack(
      dontMatch: RegExp(
        r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(common\/router\/)(vegi_debug_route_observer\.dart):(\d+):(\d+)\)',
      ),
      removeLinesContaining: [
        'vegi_debug_route_observer.dart',
        'log_it.dart',
      ],
    );
    log.info(
      '🚀 rootRouter.push: ${route.routeName} from ${this.current.route.name}: ${filteredStack.pretty()}',
      stackTraceLines: filteredStack,
    );
    return super.push(
      route,
      onFailure: onFailure,
    );
  }

  @override
  Future<bool> pop<T extends Object?>([T? result]) {
    final filteredStack = StackTrace.current.filterCallStack(
      dontMatch: RegExp(
          r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(common\/router\/)(vegi_debug_route_observer\.dart):(\d+):(\d+)\)',),
    );
    log.info(
      '🚀 rootRouter.pop from ${current.route.name}: $filteredStack',
      stackTrace: StackTrace.current,
    );
    return super.pop(result);
  }

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo<dynamic> route,
      {void Function(NavigationFailure)? onFailure,}) {
    final filteredStack = StackTrace.current.filterCallStack(
      dontMatch: RegExp(
          r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(common\/router\/)(vegi_debug_route_observer\.dart):(\d+):(\d+)\)',),
    );
    log.info(
      '🚀 rootRouter.replace: ${route.routeName} from ${current.route.name}: $filteredStack',
      stackTrace: StackTrace.current,
    );
    return super.replace(
      route,
      onFailure: onFailure,
    );
  }

  @override
  Future<void> replaceAll(List<PageRouteInfo<dynamic>> routes, {void Function(NavigationFailure)? onFailure, bool? updateExistingRoutes,}) {
    final filteredStack = StackTrace.current.filterCallStack(
      dontMatch: RegExp(
          r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(common\/router\/)(vegi_debug_route_observer\.dart):(\d+):(\d+)\)',),
    );
    log.info(
      '🚀 rootRouter.replacedAll with [${routes.map(
            (e) => e.routeName,
          ).join(",")}] from ${current.route.name}: $filteredStack',
      stackTrace: StackTrace.current,
    );
    return super.replaceAll(
      routes,
      onFailure: onFailure,
    );
  }
}
