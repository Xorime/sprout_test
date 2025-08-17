import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/controllers/pokedex_detail_controller.dart';
import 'package:sprout_test/models/pokedex_detail_model.dart';
import 'package:sprout_test/utils/constants.dart';
import 'package:sprout_test/utils/extensions.dart';
import 'package:sprout_test/utils/wgt.dart';

class PokedexDetail extends StatelessWidget {
  final String url;

  PokedexDetail({
    super.key,
    required this.url,
  }) : _controller = Get.put(PokedexDetailController(url: url));

  final PokedexDetailController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
          ),
          forceMaterialTransparency: true,
          title: Text(
            'Pokedex ${_controller.model.value.region?.name ?? 'National'} Region',
            style: context.workSans(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (_controller.state.value == ControllerState.loading) {
      return Column(
        children: [
          for (int i = 0; i < 10; i++) ...[
            Wgt.loaderBox(width: Get.width),
            SizedBox(height: kPadding12),
          ],
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _controller.load(),
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: ListView.builder(
          padding: EdgeInsets.all(kPadding12),
          itemCount: (_controller.model.value.pokemonEntries ?? []).length,
          itemBuilder: (context, index) {
            PokemonEntries model = (_controller.model.value.pokemonEntries ?? [])[index];

            return GestureDetector(
              onTap: () => _controller.onTapPokedex(model: model),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding12),
                margin: EdgeInsets.symmetric(vertical: kPadding8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.pokemonSpecies?.name ?? 'Undefined',
                      style: context.workSans(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Image.asset(
                      kImagePokeball,
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
