import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvvm_example/lang/ar_AE.dart';
import 'package:mvvm_example/lang/en_US.dart';
import 'package:mvvm_example/lang/hi_IN.dart';
import 'package:get/get.dart';


class LocalizationService extends Translations {
   // Default locale
  static final locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'Hindi', 'Arabic'];

    // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('ar', 'AE'),
  ];

    // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // lang/en_us.dart
        'hi_IN': hiIn, // lang/hi_IN.dart
        'ar_AE': arAE, // lang/ar_AE.dart
      };
      
    void changeLocale(String lang) {
      final locale = getLocaleFromLanguage(lang);
      final box = GetStorage();
      box.write('lng', lang);
      Get.updateLocale(locale);
    }

    Locale getLocaleFromLanguage(String lang) {
      for(int i=0; i < langs.length; i++) {
        if (lang == langs[i]) return locales[i];
      }

      return Get.locale!;
    }

      Locale getCurrentLocale() {
    final box = GetStorage();
    Locale defaultLocale;

    if (box.read('lng') != null) {
      final locale =
          LocalizationService().getLocaleFromLanguage(box.read('lng'));

      defaultLocale = locale;
    } else {
      defaultLocale = Locale(
        'en',
        'US',
      );
    }

    return defaultLocale;
  }

    String getCurrentLang() {
     final box = GetStorage();

     return box.read('lng') != null ? box.read('lng') : "English";
  }
  
}