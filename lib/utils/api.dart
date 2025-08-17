import 'package:sprout_test/base/base_api.dart';
import 'package:sprout_test/base/base_controllers.dart';

String baseUrl = 'https://pokeapi.co/api/v2/';

class Api extends BaseApi {
  String _getPokedexList = baseUrl + 'pokedex';

  Future<void> getPokedexList({required BaseControllers controllers, String? nextUrl}) => apiFetch(
        url: nextUrl != null ? nextUrl : _getPokedexList,
        controller: controllers,
        debug: false,
      );

  Future<void> getPokedexDetail({required BaseControllers controllers, required String url}) => apiFetch(
        url: url,
        controller: controllers,
        debug: false,
      );

  Future<void> getPokemonDetail({required BaseControllers controllers, required int pokemonID}) => apiFetch(
        url: baseUrl + 'pokemon/$pokemonID',
        controller: controllers,
        debug: false,
      );
}
