import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:spend_wise/core/resource/custom_widget/snake_bar_widget/snake_bar_widget.dart';
import 'package:spend_wise/core/resource/main_page/drawer.dart';
import 'package:spend_wise/core/resource/main_page/main_bottom_bar.dart';

class MainPage extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final String? pagePath;

  final List<Widget>? actions;
  const MainPage({
    super.key,
    required this.body,
    this.title,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.actions,
    this.pagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? ""),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  size: 32.sp,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions:
              actions ??
              [
                IconButton(
                  onPressed:
                      context.canPop()
                          ? () =>
                              context.canPop()
                                  ? context.pop()
                                  : showMessage(
                                    message: "Can not pop",
                                    context: context,
                                  )
                          : null,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 32.sp,
                    color:
                        context.canPop()
                            ? Theme.of(context).textTheme.displayLarge?.color
                            : Theme.of(context).disabledColor,
                  ),
                ),
              ],
        ),
        body: body,
        drawer: drawer ?? CustomDrawer(currentPagePath: pagePath),
        floatingActionButton: floatingActionButton,

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
