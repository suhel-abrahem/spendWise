import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_wise/core/constants/language_constant.dart';

import '../../../config/route/routes_manager.dart';
import '../../../generated/locale_keys.g.dart';
import '../../resource/color_manager.dart';

class Helper {
  static String nameLanguageSelector<T>({
    required BuildContext context,
    required int? defaultLanguage,
    required List<T?>? names,
  }) {
    String output = '';
    switch (context.locale) {
      case LanguageConstant.arLoacle:
        ((names?.isNotEmpty ?? false) &&
                names![0] != null &&
                names[0].toString().trim().isNotEmpty)
            ? output = names[0].toString()
            : output =
                ((names?.isNotEmpty ?? false) &&
                        names?[defaultLanguage ?? 0] != null)
                    ? names![defaultLanguage ?? 0].toString()
                    : '';
        break;
      case LanguageConstant.enLoacle:
        ((names?.length ?? 0) > 1 &&
                names?[1] != null &&
                (names?[1].toString().trim().isNotEmpty ?? false))
            ? output = names![1].toString()
            : output =
                ((names?.isNotEmpty ?? false) &&
                        (names?[defaultLanguage ?? 0] != null))
                    ? names![defaultLanguage ?? 0].toString()
                    : '';
        break;
      case LanguageConstant.faLocale:
        ((names?.length ?? 0) > 2 &&
                names?[2] != null &&
                (names?[2].toString().trim().isNotEmpty ?? false))
            ? output = names![2].toString()
            : output =
                ((names?.isNotEmpty ?? false) &&
                        (names?[defaultLanguage ?? 0] != null))
                    ? names![defaultLanguage ?? 0].toString()
                    : '';
        break;
      default:
        output =
            ((names?.isNotEmpty ?? false) &&
                    (names?[defaultLanguage ?? 0] != null))
                ? names![defaultLanguage ?? 0].toString()
                : '';
        break;
    }
    return output;
  }

  static int languageNameToInt(String languageName) {
    return languageName == LocaleKeys.fa
        ? 2
        : languageName == LocaleKeys.en
        ? 1
        : 0;
  }

  static Locale getLocaleByCode(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return LanguageConstant.arLoacle;
      case 'en':
        return LanguageConstant.enLoacle;
      case 'fa':
        return LanguageConstant.faLocale;
      default:
        return LanguageConstant.enLoacle;
    }
  }

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return LanguageConstant.supportedLanguagesNames[0];
      case 'en':
        return LanguageConstant.supportedLanguagesNames[1];
      case 'fa':
        return LanguageConstant.supportedLanguagesNames[2];
      default:
        return LanguageConstant.supportedLanguagesNames[1];
    }
  }

  static Locale getLocaleByName(String languageName) {
    switch (languageName) {
      case LanguageConstant.arName:
        return LanguageConstant.arLoacle;
      case LanguageConstant.enName:
        return LanguageConstant.enLoacle;
      case LanguageConstant.faName:
        return LanguageConstant.faLocale;
      default:
        return LanguageConstant.enLoacle;
    }
  }

  static RichText labelText({
    String label = '',
    bool isRequired = true,
    TextStyle? labelStyle,
    bool readText = false,
  }) {
    return RichText(
      text: TextSpan(
        text: label,
        style:
            labelStyle ??
            (navigatorKey.currentContext != null
                ? (readText
                    ? Theme.of(
                      navigatorKey.currentContext!,
                    ).textTheme.labelLarge?.copyWith(
                      color:
                          Theme.of(
                            navigatorKey.currentContext!,
                          ).colorScheme.error,
                    )
                    : Theme.of(
                      navigatorKey.currentContext!,
                    ).textTheme.labelLarge)
                : TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textColor,
                )),
        children: [
          if (isRequired && label.isNotEmpty)
            TextSpan(
              text: " *",
              style:
                  navigatorKey.currentContext != null
                      ? Theme.of(
                        navigatorKey.currentContext!,
                      ).inputDecorationTheme.errorStyle
                      : const TextStyle(color: ColorManager.error),
            ),
        ],
      ),
    );
  }
}
