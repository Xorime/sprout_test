import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_test/base/base_controllers.dart';
import 'package:sprout_test/controllers/favourite_pokemon_controller.dart';
import 'package:sprout_test/models/pokemon_detail_model.dart';
import 'package:sprout_test/utils/constants.dart';
import 'package:sprout_test/utils/keys.dart';
import 'package:sprout_test/utils/utils.dart';

class PokemonDetailController extends BaseControllers {
  final String url;

  PokemonDetailController({required this.url});

  Rx<PokemonDetailModel> model = PokemonDetailModel().obs;
  RxInt selectedIndex = 0.obs;
  RxBool isFavourite = false.obs;

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
    _parseFavourite();
  }

  Future<void> _parseFavourite() async {
    List temp = await GetStorage().read(storage_favourite) ?? [];
    int pokemonID = int.parse(url.split('/pokemon-species/')[1].split('/')[0]);

    if (temp.isEmpty) {
      return;
    }

    for (Map json in temp) {
      if (json['id'] == pokemonID) {
        isFavourite.value = true;
        break;
      }
    }
  }

  Future<void> onTapFavourite() async {
    List temp = await GetStorage().read(storage_favourite) ?? [];
    int pokemonID = int.parse(url.split('/pokemon-species/')[1].split('/')[0]);

    if (!isFavourite.value) {
      temp.add({
        'name': model.value.name,
        'id': pokemonID,
        'image': model.value.spriteImage,
        'url': url,
      });

      isFavourite.value = true;
    } else {
      temp.removeWhere((e) => e['id'] == pokemonID);
      isFavourite.value = false;
    }

    await GetStorage().write(storage_favourite, temp);

    if (Get.isRegistered<FavouritePokemonController>()) {
      final FavouritePokemonController _favouriteController = Get.find<FavouritePokemonController>();
      _favouriteController.fetchData();
    }
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
