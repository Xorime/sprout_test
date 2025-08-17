import 'package:get/get.dart';
import 'package:sprout_test/base/base_controllers.dart';
import 'package:sprout_test/models/pokedex_detail_model.dart';
import 'package:sprout_test/screens/pokemon_detail.dart';
import 'package:sprout_test/utils/utils.dart';

class PokedexDetailController extends BaseControllers {
  final String url;

  PokedexDetailController({required this.url});

  Rx<PokedexDetailModel> model = PokedexDetailModel().obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  @override
  Future<void> load() async {
    super.load();
    await api.getPokedexDetail(controllers: this, url: url);
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
    model.value = PokedexDetailModel.fromJson(json);
  }

  void onTapPokedex({required PokemonEntries model}) {
    Get.to(() => PokemonDetail(url: model.pokemonSpecies?.url ?? ''));
  }
}
