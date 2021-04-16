import 'package:flutter/cupertino.dart';

class ImagesPath {
  static const String RootPath = "assets/images/";
  static const String AnimationsRootPath = "assets/animations/";

  static const String IconsPath = "${RootPath}icons/";
  static const String BackgroundsPath = "${RootPath}background/";
  static const String LogosPath = "${RootPath}logo/";
  static const String OnBoardingPath = "${RootPath}onboarding/";
  static const String GifAnimationPath = "${AnimationsRootPath}gifs/";
  static const String JsonAnimationPath = "${AnimationsRootPath}jsons/";
}

class RoutePath {
  static const String Home = "home";
  static const String Login = "login";
  static const String Register = "register";
  static const String OnBoarding = "onboarding";
  static const String Start = "start";
  static const String Swipe = "swipe";
  static const String Tchat = "tchat";
  static const String Profile = "profile";
  static const String Conversation = "conversation";
  static const String EditProfile = "edit_profile";
  static const String Pdf = "pdf";
  static const String DeleteUser = "delete_user";
  static const QrScan = "qrCode";
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
  static const appBackgroundImages = [
    BackgroundSplashScreen,
    BackgroundLoginLight,
    BackgroundLoginDark,
    BackgroundHomeDark,
    BackgroundQrCode
  ];

  static const BackgroundSplashScreen =
      "${ImagesPath.BackgroundsPath}background_splashscreen.png";
  static const BackgroundLoginLight =
      "${ImagesPath.BackgroundsPath}background_connexion_day.png";
  static const BackgroundLoginDark =
      "${ImagesPath.BackgroundsPath}background_connexion_night.png";
  static const BackgroundHomeDark =
      "${ImagesPath.BackgroundsPath}fond_home.png";
  static const BackgroundQrCode =
      "${ImagesPath.BackgroundsPath}background_qr_code.png";
}

class AppLogoImages {
  static const appIconsLogo = [
    LogoTextBeside,
    TextAppNameLogo,
    TransparentLogo,
    LogoTuba,
    LogoMatchWork,
    LogoMatchWorkText,
    LogoMatchWorkTextTuba,
    LogoGoogle,
    LogoApple,
    LogoMatchWorkBlue
  ];

  static const LogoTextBeside = "${ImagesPath.LogosPath}logo_text_beside.png";
  static const TextAppNameLogo =
      "${ImagesPath.LogosPath}text_app_name_logo.png";
  static const TransparentLogo = "${ImagesPath.LogosPath}transparent_logo.png";
  static const LogoTuba = "${ImagesPath.LogosPath}logo_tuba.png";
  static const LogoMatchWork = "${ImagesPath.LogosPath}splash.png";
  static const LogoMatchWorkText = "${ImagesPath.LogosPath}logo_text_below.png";
  static const LogoMatchWorkTextTuba =
      "${ImagesPath.LogosPath}logo_assembler.png";
  static const LogoGoogle = "${ImagesPath.LogosPath}google_logo.png";
  static const LogoApple = "${ImagesPath.LogosPath}apple_logo.png";
  static const LogoMatchWorkBlue = "${ImagesPath.LogosPath}blue_logo.jpg";
}

class AppImages {
  static const appImages = [
    UnknownUser,
    WelcomeWhite,
    WelcomeBlue,
    ProfilBannere,
    ProfilBannerDark,
    ProfilBannerLight,
    QrCodeSample,
    QrCodeSuccess,
    QrCodeFailed,
  ];

  static const ProfilBannere =
      "${ImagesPath.BackgroundsPath}banniere_profil1.png";
  static const UnknownUser = "${ImagesPath.RootPath}unknown_user.png";
  static const WelcomeWhite = "${ImagesPath.RootPath}welcome_white.png";
  static const WelcomeBlue = "${ImagesPath.RootPath}welcome_blue.png";
  static const ProfilBannerLight =
      "${ImagesPath.RootPath}profil_rec_banner_light.png";
  static const ProfilBannerDark =
      "${ImagesPath.RootPath}profil_rec_banner_dark.png";
  static const QrCodeSample = "${ImagesPath.RootPath}qr_code.png";
  static const QrCodeSuccess = "${ImagesPath.RootPath}rond_good.png";
  static const QrCodeFailed = "${ImagesPath.RootPath}rond_nogood.png";
}

class AppIcons {
  static const appIcons = [
    ActiveSwipe,
    InactiveSwipe,
    InactiveSwipeDark,
    ActiveProfile,
    InactiveProfile,
    InactiveProfileDark,
    ActiveChat,
    InactiveChat,
    InactiveChatDark,
    ActiveNews,
    InactiveNews,
    InactiveNewsDark,
    Logout,
    BrightnessMode,
    EditProfile,
    Tutorial,
    Settings,
    ProfilGuillemet,
    Settings,
    Coeur,
    Croix,
    Delete
  ];

  static const ActiveSwipe = "${ImagesPath.IconsPath}match_on.png";
  static const InactiveSwipe = "${ImagesPath.IconsPath}match_off.png";
  static const InactiveSwipeDark = "${ImagesPath.IconsPath}match_dark.png";
  static const ActiveProfile = "${ImagesPath.IconsPath}profil_on.png";
  static const InactiveProfile = "${ImagesPath.IconsPath}profil_off.png";
  static const InactiveProfileDark = "${ImagesPath.IconsPath}profil_dark.png";
  static const ActiveChat = "${ImagesPath.IconsPath}chat_on.png";
  static const InactiveChat = "${ImagesPath.IconsPath}chat_off.png";
  static const InactiveChatDark = "${ImagesPath.IconsPath}chat_dark.png";
  static const ActiveNews = "${ImagesPath.IconsPath}actu_on.png";
  static const InactiveNews = "${ImagesPath.IconsPath}actu_off.png";
  static const InactiveNewsDark = "${ImagesPath.IconsPath}actu_dark.png";
  static const Logout = "${ImagesPath.IconsPath}icon_deco.png";
  static const BrightnessMode = "${ImagesPath.IconsPath}icon_mode.png";
  static const EditProfile = "${ImagesPath.IconsPath}icon_modif.png";
  static const Tutorial = "${ImagesPath.IconsPath}icon_tuto.png";
  static const Settings = "${ImagesPath.IconsPath}icon_parametre.png";
  static const ProfilGuillemet = "${ImagesPath.IconsPath}profil_guillemet.png";
  static const Coeur = "${ImagesPath.IconsPath}coeur.png";
  static const Croix = "${ImagesPath.IconsPath}croix.png";
  static const Delete = "${ImagesPath.IconsPath}icon_supprimer.png";
}

class AppOnBoardingImage {
  static const onBoardingImages = [
    FirstOnBoardingmage,
    SecondOnBoardingmage,
    ThirdOnBoardingmage,
    FourOnBoardingmage,
    FiveOnBoardingmage
  ];

  static const FirstOnBoardingmage = "${ImagesPath.OnBoardingPath}tuto_1.png";
  static const SecondOnBoardingmage = "${ImagesPath.OnBoardingPath}tuto_2.png";
  static const ThirdOnBoardingmage = "${ImagesPath.OnBoardingPath}tuto_3.png";
  static const FourOnBoardingmage = "${ImagesPath.OnBoardingPath}tuto_4.png";
  static const FiveOnBoardingmage = "${ImagesPath.OnBoardingPath}tuto_5.png";
}

class AppAnimations {
  static const Loader = "${ImagesPath.GifAnimationPath}loading.gif";
  static const SplashLogo = "${ImagesPath.GifAnimationPath}splashLogo.gif";
  static const MatchLight = "${ImagesPath.GifAnimationPath}match_light.gif";
  static const MatchDark = "${ImagesPath.GifAnimationPath}match_dark.gif";
  static const SplashJsonLogo = "${ImagesPath.JsonAnimationPath}splash.json";
  static const FirstSwipe = "${ImagesPath.GifAnimationPath}FirstSwipe.gif";
}

class AppFiles {
  static const RootPath = "assets/files/";
  static const CGUBtoC = "${AppFiles.RootPath}CGU_BtoC_MatchWork.pdf";
}

class AppTitlesFiles {
  static const CGUBtoCTitle = "CGU BtoC";
}
