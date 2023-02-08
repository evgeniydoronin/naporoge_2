import 'package:flutter/material.dart';

// REMOTE SRC
class RemoteAssets {
  static const String host = 'https://np-app.evgeniydoronin.com';
  static const String videoFolder = '/assets/video';
  static const String imagesFolder = '/assets/images';

  videoAssets() {
    return host + videoFolder;
  }

  imagesAssets() {
    return host + imagesFolder;
  }
}

// Colors
class ColorApp {
  static const Color primary = Color(0xFF00A2FF);
  static const Color secondaryText = Color(0xFFBDBDBD);
  static const Color disableInputField = Color(0xFFF9F9F9);
  static const Color lightGrey = Color(0xFFEEEEEF);
  static const Color warningColor = Color(0xFFFB7181);

  /// status day
  static const Color statusDayPlannedBG = Color(0xFFFFFFFF);
  static const Color statusDayPlannedText = Color(0xFF000000);
  static const Color statusDayCompletedOnTimeBG = Color(0xFF00A2FF);
  static const Color statusDayCompletedOnTimeText = Color(0xFF000000);
  static const Color statusDayNotDoneOnTimeBG = Color(0x6100A2FF);
  static const Color statusDayNotDoneOnTimeText = Color(0xFF000000);
  static const Color statusDayNotCompletedBG = Color(0xFFC4C4C4);
  static const Color statusDayNotCompletedText = Color(0xFF000000);
  static const Color statusDayDoneOffPlanBG = Color(0xFFFFFFFF);
  static const Color statusDayDoneOffPlanText = Color(0xFFFF6E6E);
}

// Radius
const BorderRadius primaryRadius = BorderRadius.all(Radius.circular(13.0));
// Fonts
const String npFontDefault = 'SFProDisplay';

// Sizes
const headerTextSize = 18.0;
const buttonTextSize = 18.0;
const titleTextSize = 18.0;
const dealTitleSize = 13.0;
const dealDescriptionSize = 14.0;
