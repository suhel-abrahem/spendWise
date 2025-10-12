import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_wise/config/route/routes_manager.dart';
import 'package:spend_wise/core/constants/language_constant.dart';
import 'package:spend_wise/core/resource/main_page/main_page.dart';
import 'package:spend_wise/features/setting/presentation/pages/account_setting_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> pages = [AccountSettingPage()];
  double pageSelectorPosition = -60.w;
  bool isPageSelectorVisible = false;
  double pageSelectorMaxPostion = 8.w;
  double pageSelectorMinPosition = -60.w;
  @override
  Widget build(BuildContext context) {
    return MainPage(
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              children: pages,
            ),
          ),
          PositionedDirectional(
            top: 0,
            bottom: 0,
            start: pageSelectorPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  if (pageSelectorPosition <= pageSelectorMaxPostion ||
                      (pageSelectorPosition >= pageSelectorMinPosition &&
                          pageSelectorPosition <= pageSelectorMaxPostion)) {
                    isPageSelectorVisible = true;
                    pageSelectorPosition += details.delta.dx;
                  }
                });
              },
              onHorizontalDragEnd: (details) {
                if (pageSelectorPosition <= pageSelectorMinPosition + 20.w) {
                  setState(() {
                    isPageSelectorVisible = false;
                    pageSelectorPosition = pageSelectorMinPosition;
                  });
                }
              },
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 200.h,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        isPageSelectorVisible ? 30.r : 12.r,
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_circle_outlined,
                            size: 32.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 30.w,
                    height: 60.h,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.horizontal(
                        end: Radius.circular(12.r),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: AnimatedRotation(
                      duration: Duration(milliseconds: 300),
                      turns: isPageSelectorVisible ? 0.5 : 1,
                      child: Center(
                        child: Icon(
                          (context.locale == LanguageConstant.arLoacle ||
                                  context.locale == LanguageConstant.faLocale)
                              ? Icons.arrow_left_rounded
                              : Icons.arrow_right_rounded,
                          size: 52.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      title: "Setting Page",
      pagePath: RoutesPath.settingPage,
    );
  }
}
