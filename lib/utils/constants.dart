import 'package:flutter/material.dart';

// Color
const kColorPrimaryBlue = Color(0xFF00B9CC);
const kColorWhite = Color(0xFFFFFFFF);
const kColorAccentYellow = Color(0xFFFFD700);
const kColorDarkTeal = Color(0xFF013A46);
const kColorCoolGray = Color(0xFFB0BEC5);
const kColorSoftBlue = Color(0xFFE0F7FA);
const kColorMintGreen = Color(0xFF00E5A0);

const kColorPrimaryRed = Color(0xFFee1515);

const kColorElementalNormal = Color(0xFFA8A77A);
const kColorElementalFire = Color(0xFFEE8130);
const kColorElementalWater = Color(0xFF6390F0);
const kColorElementalElectric = Color(0xFFF7D02C);
const kColorElementalGrass = Color(0xFF7AC74C);
const kColorElementalIce = Color(0xFF96D9D6);
const kColorElementalFighting = Color(0xFFC22E28);
const kColorElementalPoison = Color(0xFFA33EA1);
const kColorElementalGround = Color(0xFFE2BF65);
const kColorElementalFlying = Color(0xFFA98FF3);
const kColorElementalPsychic = Color(0xFFF95587);
const kColorElementalBug = Color(0xFFA6B91A);
const kColorElementalRock = Color(0xFFB6A136);
const kColorElementalGhost = Color(0xFF735797);
const kColorElementalDragon = Color(0xFF6F35FC);
const kColorElementalDark = Color(0xFF705746);
const kColorElementalSteel = Color(0xFFB7B7CE);
const kColorElementalFairy = Color(0xFFD685AD);

// Padding
const kPadding8 = 8.0;
const kPadding12 = 12.0;
const kPadding16 = 16.0;
const kPadding20 = 20.0;
const kPadding24 = 24.0;
const kPadding32 = 32.0;
const kPadding36 = 36.0;

const kSizeBottomBarHeight = 80.0;

// Styles
const headline1 = TextStyle(fontSize: 24, color: kColorDarkTeal);
const headline2 = TextStyle(fontSize: 18, color: kColorDarkTeal);
const headline3 = TextStyle(fontSize: 16, color: kColorDarkTeal);
const headline4 = TextStyle(fontSize: 14, color: kColorDarkTeal);
const headline5 = TextStyle(fontSize: 12, color: kColorDarkTeal);
const bodyText1 = TextStyle(fontSize: 14, color: kColorDarkTeal);
const bodyText2 = TextStyle(fontSize: 12, color: kColorDarkTeal);
const subtitle1 = TextStyle(fontSize: 10, color: kColorDarkTeal);
const subtitle2 = TextStyle(fontSize: 8, color: kColorDarkTeal);
const button = TextStyle(fontSize: 13.6, color: kColorDarkTeal);

//Images
const kImageDevFlag = 'assets/dev-flag.png';
const kImagePokeball = 'assets/pokeball.png';
const kImageSword = 'assets/swords.png';

const kPopupSuccess = 'success';
const kPopupFailed = 'failed';

// constants

const kSizeMinButtonWidth = 100.0;
const kSizeMinButtonHeight = 45.0;

const kSizeRadiusButton = 25.0;

const kIndexHome = 0;
const kIndexFavourite = 1;

const kSizeLoaderBoxWidth = 200.0;
const kSizeLoaderBoxHeight = 50.0;
const kSizeLoaderBoxRadius = 10.0;

//enums

enum ControllerState {
  firstLoad,
  loading,
  loadingSuccess,
  loadingFailed,
  reload,
}
