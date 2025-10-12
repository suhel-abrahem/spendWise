import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spend_wise/config/route/route_tracker.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';
import 'package:spend_wise/features/categories/presentation/pages/categories_page.dart';
import 'package:spend_wise/features/home/presentation/pages/home_page.dart';
import 'package:spend_wise/features/setting/presentation/pages/setting_page.dart';

import '../../core/resource/main_page/main_bottom_bar.dart';
import '../../core/resource/main_page/main_page.dart';
import '../../features/category_page/presentation/pages/category_page.dart';

class RoutesName {
  static String homePage = "homePage";
  static String categoriesPage = "categoriesPage";
  static String settingPage = "settingPage";
  static String categoryPage = "categoryPage";
}

class RoutesPath {
  static String homePage = '/';
  static String categoriesPage = '/categories';
  static String settingPage = '/setting';
  static String categoryPage = '/category';
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GoRouter goRouter = GoRouter(
  observers: [RouteTracker()],
  redirect: (context, state) {},
  initialLocation: RoutesPath.homePage,
  navigatorKey: navigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) => ThemeSwitchingArea(
            child: Scaffold(
              body: navigationShell,
              bottomNavigationBar: MainBottomBar(
                currentRoute: state.uri.toString(),
              ),
            ),
          ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutesPath.homePage,
              name: RoutesName.homePage,
              pageBuilder:
                  (context, state) =>
                      _customTransitionPage(child: HomePage(), state: state),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutesPath.categoriesPage,
              name: RoutesName.categoriesPage,
              pageBuilder:
                  (context, state) => _customTransitionPage(
                    child: CategoriesPage(),
                    state: state,
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutesPath.settingPage,
              name: RoutesName.settingPage,
              pageBuilder:
                  (context, state) =>
                      _customTransitionPage(child: SettingPage(), state: state),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutesPath.categoryPage,
              name: RoutesName.categoryPage,
              pageBuilder:
                  (context, state) => _customTransitionPage(
                    child: CategoryPage(
                      categoryEntity: state.extra as CategoryEntity?,
                    ),
                    state: state,
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
CustomTransitionPage _customTransitionPage({
  required Widget child,
  GoRouterState? state,
}) {
  return CustomTransitionPage(
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 300),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        key: state?.pageKey,
        opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
        // opacity: animation,
        child: child,
      );
    },
  );
}
