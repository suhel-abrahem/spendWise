import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spend_wise/config/app/app.dart';
import 'package:spend_wise/config/app/app_preferences.dart';
import 'package:spend_wise/core/constants/language_constant.dart';
import 'package:spend_wise/core/dependencies_injection.dart';
import 'package:spend_wise/core/util/helper/helper.dart';
import 'package:spend_wise/firebase_options.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    EasyLocalization(
      supportedLocales: LanguageConstant.supportedLocales,
      path: LanguageConstant.path,
      saveLocale: true,
      startLocale: Helper.getLocaleByCode(
        getItInstance<AppPreferences>().getLanguage() ?? LanguageConstant.en,
      ),
      fallbackLocale: LanguageConstant.arLoacle,
      child: SpeandWise(),
    ),
  );
}
