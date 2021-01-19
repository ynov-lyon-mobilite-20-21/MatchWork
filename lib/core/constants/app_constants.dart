import 'package:flutter/cupertino.dart';

class RoutePath {
  static const String Home = "/";
  static const String Login = "login";
  static const String Register = "register";
  static const String Swipe = "swipe";
  static const String Chat = "chat";
  static const String Profile = "profile";
}

class AppColors{
  static const PrimaryColor = const Color(0xff0083a0);
  static const SecondColor = const Color(0xff1A4246);
  static const AccentColor = const Color(0xff5FC0C2);
  static const AppBarColor = const Color(0xff006E7F);
  static const StatusBarColor = const Color(0xff184246);
}

class AppBackgroundImages {
  static const appBackgroundImages = [SplashscreenBackground];
  static const _baseUri = "assets/images/background/";

  static const SplashscreenBackground = "${_baseUri}background_splashscreen.png";
}

class AppLogoImages {
  static const appIconsLogo = [
    BlueLogo,
    LogoTextBelow,
    LogoTextBeside,
    TubaLogo,
    TextAppNameLogo,
    TransparentLogo
  ];

  static const _baseUri = "assets/images/logo/";

  static const BlueLogo = "${_baseUri}blue_logo.jpg";
  static const LogoTextBelow = "${_baseUri}logo_text_below.png";
  static const LogoTextBeside = "${_baseUri}logo_text_beside.png";
  static const TubaLogo = "${_baseUri}logo_tuba.png";
  static const TextAppNameLogo = "${_baseUri}text_app_name_logo.png";
  static const TransparentLogo = "${_baseUri}transparent_logo.png";
}

class AppIcons {
  static const appIconsArray = [
    ActiveSwipe,
    InactiveSwipe,
    ActiveProfile,
    InactiveProfile,
    ActiveChat,
    InactiveChat
  ];

  static const _baseUri = "assets/images/icons/";

  static const ActiveSwipe = "${_baseUri}match_on.png";
  static const InactiveSwipe = "${_baseUri}match_off.png";
  static const ActiveProfile = "${_baseUri}profil_on.png";
  static const InactiveProfile = "${_baseUri}profil_off.png";
  static const ActiveChat = "${_baseUri}tchat_on.png";
  static const InactiveChat = "${_baseUri}tchat_off.png";
}

class AppCarouselImage {
  static const carouselImages = [ AppLogoImages.BlueLogo, AppLogoImages.TubaLogo, AppBackgroundImages.SplashscreenBackground];
}