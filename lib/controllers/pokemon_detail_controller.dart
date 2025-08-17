import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/base/base_controllers.dart';
import 'package:sprout_test/models/pokemon_detail_model.dart';
import 'package:sprout_test/utils/constants.dart';
import 'package:sprout_test/utils/utils.dart';

class PokemonDetailController extends BaseControllers {
  final String url;

  PokemonDetailController({required this.url});

  Rx<PokemonDetailModel> model = PokemonDetailModel().obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  @override
  Future<void> load() async {
    super.load();

    int pokemonID = int.parse(url.split('/pokemon-species/')[1].split('/')[0]);
    await api.getPokemonDetail(controllers: this, pokemonID: pokemonID);
  }

  @override
  void loadSuccess({required int requestCode, required response, required int statusCode}) {
    super.loadSuccess(requestCode: requestCode, response: response, statusCode: statusCode);
    setLoading(false);
    _parseData(response);
  }

  @override
  void loadFailed({required int requestCode, required Response response}) {
    super.loadFailed(requestCode: requestCode, response: response);
    setLoading(false);
    Utils.popUpFailed(body: response.body['message']);
  }

  void _parseData(Map json) {
    model.value = PokemonDetailModel.fromJson(json);
  }

  void onTapInfo({required int index}) {
    selectedIndex.value = index;
  }

  Color getColor() {
    for (String type in model.value.types) {
      switch (type) {
        case 'grass':
          return kColorElementalGrass;
        case 'water':
          return kColorElementalWater;
        case 'fire':
          return kColorElementalFire;
        case 'bug':
          return kColorElementalBug;
        case 'normal':
          return kColorElementalNormal;
        case 'poison':
          return kColorElementalPoison;
        case 'ground':
          return kColorElementalGround;
        case 'fighting':
          return kColorElementalFighting;
        case 'psychic':
          return kColorElementalPsychic;
        case 'fairy':
          return kColorElementalFairy;
      }
    }

    return Colors.transparent;
  }
}
