import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/base/base_controllers.dart';
import 'package:sprout_test/utils/constants.dart';

class RootController extends BaseControllers {
  RxBool isLoggedIn = false.obs;
  RxInt index = 0.obs;
  late TabController tabController;
  List<Widget> screens = [];

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> handleBack() async {
    if (tabController.index != 0) {
      navigateToHome();
      return false;
    }
    if (tabController.index == 0) {
      exit(0);
    }
    return false;
  }

  void navigateToHome() {
    tabController.animateTo(kIndexHome);
    index.value = kIndexHome;
  }

  void navigateToFavourite() {
    tabController.animateTo(kIndexFavourite);
    index.value = kIndexFavourite;
  }

  void navigateTo(int target) {
    tabController.animateTo(target);
    index.value = target;
  }
}
