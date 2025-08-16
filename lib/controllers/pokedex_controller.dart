import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/base/base_controllers.dart';
import 'package:sprout_test/utils/utils.dart';

class PokedexController extends BaseControllers {
  RxList<PokedexModel> arrData = RxList();

  ScrollController scrollController = ScrollController();
  bool enableLoadMore = true;
  String? nextUrl;

  @override
  void onInit() {
    super.onInit();
    setupScrollListener();
    load();
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          // You're at the bottom.
          loadMore();
        }
      }
    });
  }

  @override
  Future<void> load() async {
    super.load();
    setLoading(true);
    await api.getPokedexList(controllers: this);
  }

  Future<void> loadMore() async {
    if (!enableLoadMore) return;
    if (nextUrl != null) api.getPokedexList(controllers: this, nextUrl: nextUrl);
  }

  void onRefresh() {
    nextUrl = null;
    load();
  }

  @override
  void loadSuccess({required int requestCode, required response, required int statusCode}) {
    super.loadSuccess(requestCode: requestCode, response: response, statusCode: statusCode);
    setLoading(false);
    _parseData(response['results'] ?? []);
    _parsePagination(response['next']);
  }

  @override
  void loadFailed({required int requestCode, required Response response}) {
    super.loadFailed(requestCode: requestCode, response: response);
    Utils.popUpFailed(body: response.body['message']);
  }

  void _parseData(List data) {
    if (nextUrl == null) {
      arrData.clear();
    }

    for (Map json in data) {
      PokedexModel model = PokedexModel.fromJson(json);
      arrData.add(model);
    }
    print(arrData.length);
  }

  void _parsePagination(String? next) {
    nextUrl = next;
  }
}

class PokedexModel {
  String name = '';
  String url = '';

  PokedexModel({
    this.name = '',
    this.url = '',
  });

  PokedexModel.fromJson(Map json) {
    name = json['name'] ?? '';
    url = json['url'] ?? '';
  }
}
