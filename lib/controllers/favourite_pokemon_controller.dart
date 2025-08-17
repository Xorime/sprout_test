import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_test/base/base_controllers.dart';
import 'package:sprout_test/screens/pokemon_detail.dart';
import 'package:sprout_test/utils/keys.dart';

class FavouritePokemonController extends BaseControllers {
  RxList<FavouritePokemonModel> arrData = RxList();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    arrData.clear();

    List temp = await GetStorage().read(storage_favourite) ?? [];

    if (temp.isEmpty) {
      return;
    }

    setLoading(true);

    for (Map json in temp) {
      FavouritePokemonModel model = FavouritePokemonModel.fromJson(json);
      arrData.add(model);
    }

    setLoading(false);
  }

  void onTapPokemon({required FavouritePokemonModel model}) {
    Get.to(() => PokemonDetail(url: model.url));
  }
}

class FavouritePokemonModel {
  int id = 0;
  String name = '';
  String image = '';
  String url = '';

  FavouritePokemonModel({
    this.id = 0,
    this.name = '',
    this.image = '',
    this.url = '',
  });

  FavouritePokemonModel.fromJson(Map json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    url = json['url'] ?? '';
  }
}
