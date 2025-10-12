import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_wise/config/app/app_preferences.dart';

import 'package:spend_wise/config/route/routes_manager.dart';
import 'package:spend_wise/config/theme/app_theme.dart';
import 'package:spend_wise/core/constants/language_constant.dart';
import 'package:spend_wise/core/dependencies_injection.dart';
import 'package:spend_wise/core/extensions/theme_data_extensions.dart';
import 'package:spend_wise/generated/locale_keys.g.dart';

class SpeandWise extends StatelessWidget {
  const SpeandWise({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        Theme.of(context).switchTheme;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
        return ThemeProvider(
          initTheme:
              (getItInstance<AppPreferences>().getAppTheme() ?? false)
                  ? darkTheme()
                  : lightTheme(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: LocaleKeys.appName.tr(),
            themeMode:
                (getItInstance<AppPreferences>().getAppTheme() ?? false)
                    ? ThemeMode.dark
                    : ThemeMode.light,
            theme:
                (getItInstance<AppPreferences>().getAppTheme() ?? false)
                    ? darkTheme()
                    : lightTheme(),

            supportedLocales: LanguageConstant.supportedLocales,
            routerConfig: goRouter,
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
          ),
        );
      },
    );
  }
}
