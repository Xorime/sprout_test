import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/controllers/pokedex_controller.dart';
import 'package:sprout_test/utils/constants.dart';
import 'package:sprout_test/utils/extensions.dart';
import 'package:sprout_test/utils/wgt.dart';

class Pokedex extends StatelessWidget {
  final PokedexController _controller = Get.put(PokedexController());

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
      return Wgt.loaderBox();
    }

    return RefreshIndicator(
      onRefresh: () async => _controller.onRefresh(),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(kPadding12),
              controller: _controller.scrollController,
              itemCount: _controller.arrData.length,
              itemBuilder: (context, index) {
                PokedexModel model = _controller.arrData[index];

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
                          model.name,
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
          SizedBox(height: 65),
        ],
      ),
    );
  }
}
