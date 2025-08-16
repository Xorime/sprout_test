import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_test/app.dart';
import 'package:sprout_test/utils/constants.dart';

Future<void> mainCommon(Environment flavor) async {
  runZonedGuarded<Future<void>>(() async {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return const Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OOPS, This is awkward.......',
                  style: headline2,
                ),
                Text(
                  ':(',
                  style: headline2,
                ),
                Text(
                  'Please contact our customer service',
                  style: bodyText1,
                ),
              ],
            ),
          ),
        ),
      );
    };

    await setupInitializers(flavor);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(App(flavor: flavor)),
    );
  }, (error, stack) {
    if (kDebugMode) {
      print(error);
    }
  });
}

Future<void> setupInitializers(Environment flavor) async {
  // Themes
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
}
