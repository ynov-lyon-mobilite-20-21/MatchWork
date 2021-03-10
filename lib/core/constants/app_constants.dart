import 'package:flutter/cupertino.dart';

class ImagesPath {
  static const String RootPath = "assets/images/";
  static const String IconsPath = "${RootPath}icons/";
  static const String BackgroundsPath = "${RootPath}background/";
  static const String LogosPath = "${RootPath}logo/";
  static const String CarouselPath = "${RootPath}tuto/";
}

class RoutePath {
  static const String Home = "/";
  static const String Login = "login";
  static const String Register = "register";
  static const String Tutorial = "tutorial";
  static const String Start = "start";
  static const String Swipe = "swipe";
  static const String Tchat = "tchat";
  static const String Profile = "profile";
  static const String Conversation = "conversation";
}

class AppColors {
  static const PrimaryColor = const Color(0xff0083a0);
  static const SecondColor = const Color(0xff1A4246);
  static const AccentColor = const Color(0xff5FC0C2);
  static const AppBarColor = const Color(0xff006E7F);
  static const StatusBarColor = const Color(0xff184246);
  static const BackgroundLightColor = const Color(0xFFE5E5E5);
  static const BackgroundDarkColor = const Color(0xff0083a0);
  static const CircleAvatarBorderColor = const Color(0xff00C4C4);
}

class AppBackgroundImages {
  static const appBackgroundImages = [BackgroundSplashScreen, BackgroundLoginLight, BackgroundLoginDark];

  static const BackgroundSplashScreen =
      "${ImagesPath.BackgroundsPath}background_splashscreen.png";
  static const BackgroundLoginLight =
      "${ImagesPath.BackgroundsPath}background_connexion_day.png";
  static const BackgroundLoginDark =
      "${ImagesPath.BackgroundsPath}background_connexion_night.png";

}

class AppLogoImages {
  static const appIconsLogo = [
    LogoTextBeside,
    TextAppNameLogo,
    TransparentLogo,
    LogoTuba,
    LogoMatchWork,
    LogoMatchWorkText,
    LogoGoogle,
    LogoLinkedIn,
    LogoMatchWorkBlue,

  ];

  static const LogoTextBeside = "${ImagesPath.LogosPath}logo_text_beside.png";
  static const TextAppNameLogo =
      "${ImagesPath.LogosPath}text_app_name_logo.png";
  static const TransparentLogo = "${ImagesPath.LogosPath}transparent_logo.png";
  static const LogoTuba = "${ImagesPath.LogosPath}logo_tuba.png";
  static const LogoMatchWork = "${ImagesPath.LogosPath}splash.png";
  static const LogoMatchWorkText = "${ImagesPath.LogosPath}logo_text_below.png";
  static const LogoGoogle = "${ImagesPath.LogosPath}google_logo.png";
  static const LogoLinkedIn = "${ImagesPath.LogosPath}linkedin_logo.png";
  static const LogoMatchWorkBlue = "${ImagesPath.LogosPath}blue_logo.jpg";

}

class AppImages {
  static const appImages = [UnknownUser, WelcomeWhite, WelcomeBlue, ProfilBannere];

  static const ProfilBannere =
      "${ImagesPath.BackgroundsPath}banniere_profil1.png";
  static const UnknownUser = "${ImagesPath.RootPath}unknown_user.png";
  static const WelcomeWhite = "${ImagesPath.RootPath}welcome_white.png";
  static const WelcomeBlue = "${ImagesPath.RootPath}welcome_blue.png";
}

class AppIcons {
  static const appIcons = [
    ActiveSwipe,
    InactiveSwipe,
    ActiveProfile,
    InactiveProfile,
    ActiveChat,
    InactiveChat,
    Coeur,
    Croix
  ];

  static const ActiveSwipe = "${ImagesPath.IconsPath}match_on.png";
  static const InactiveSwipe = "${ImagesPath.IconsPath}match_off.png";
  static const ActiveProfile = "${ImagesPath.IconsPath}profil_on.png";
  static const InactiveProfile = "${ImagesPath.IconsPath}profil_off.png";
  static const ActiveChat = "${ImagesPath.IconsPath}tchat_on.png";
  static const InactiveChat = "${ImagesPath.IconsPath}tchat_off.png";
  static const Coeur = "${ImagesPath.IconsPath}coeur.png";
  static const Croix = "${ImagesPath.IconsPath}croix.png";
}

class AppCarouselImage {
  static const carouselImages = [
    FirstTutoImage,
    SecondTutoImage,
    ThirdTutoImage,
    FourTutoImage,
    FiveTutoImage
  ];

  static const FirstTutoImage = "${ImagesPath.CarouselPath}tuto_1.png";
  static const SecondTutoImage = "${ImagesPath.CarouselPath}tuto_2.png";
  static const ThirdTutoImage = "${ImagesPath.CarouselPath}tuto_3.png";
  static const FourTutoImage = "${ImagesPath.CarouselPath}tuto_4.png";
  static const FiveTutoImage = "${ImagesPath.CarouselPath}tuto_5.png";
}
