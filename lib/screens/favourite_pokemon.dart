import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/controllers/favourite_pokemon_controller.dart';
import 'package:sprout_test/utils/constants.dart';
import 'package:sprout_test/utils/extensions.dart';
import 'package:sprout_test/utils/img.dart';
import 'package:sprout_test/utils/wgt.dart';

class FavouritePokemon extends StatelessWidget {
  final FavouritePokemonController _controller = Get.put(FavouritePokemonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Pokedex',
          style: context.workSans(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() => _body(context)),
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

    if (_controller.arrData.isEmpty) {
      return Center(
        child: Text(
          'Nothing to see here!\n\nAdd Pokemon to this page by clicking Star icon inside Pokemon details!',
          textAlign: TextAlign.center,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _controller.fetchData(),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(kPadding12),
              itemCount: _controller.arrData.length,
              itemBuilder: (context, index) {
                FavouritePokemonModel model = _controller.arrData[index];

                return GestureDetector(
                  onTap: () => _controller.onTapPokemon(model: model),
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
                          model.name,
                          style: context.workSans(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Img(
                            url: model.image,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 65),
        ],
      ),
    );
  }
}
