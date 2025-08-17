import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_test/controllers/pokemon_detail_controller.dart';
import 'package:sprout_test/utils/constants.dart';
import 'package:sprout_test/utils/extensions.dart';
import 'package:sprout_test/utils/img.dart';
import 'package:sprout_test/utils/wgt.dart';

class PokemonDetail extends StatelessWidget {
  final String url;

  PokemonDetail({
    super.key,
    required this.url,
  }) : _controller = Get.put(PokemonDetailController(url: url));

  final PokemonDetailController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_controller.state.value == ControllerState.loading) {
          return Wgt.loaderController();
        }

        return Scaffold(
          backgroundColor: _controller.getColor(),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => _controller.onTapFavourite(),
                icon: Icon(
                  Icons.star_border,
                  color: _controller.isFavourite.value ? Colors.yellow : null,
                ),
              ),
            ],
            forceMaterialTransparency: true,
            title: Text(
              '',
              style: context.workSans(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          body: _body(context),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        _background(),
        _header(context),
        Positioned(
          bottom: Get.width / 500,
          child: _infoDetails(context),
        ),
        Align(
          alignment: Alignment(0.02, -0.8),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Img(
              url: _controller.model.value.spriteImage,
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _controller.model.value.name.toUpperCase(),
            style: context.workSans(color: kColorWhite, fontWeight: FontWeight.w700, fontSize: 32),
          ),
          SizedBox(height: kPadding8),
          _typeGenerator(context),
        ],
      ),
    );
  }

  Widget _typeGenerator(BuildContext context) {
    return Row(
      children: [
        for (String types in _controller.model.value.types) ...[
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: kPadding12),
            margin: EdgeInsets.only(right: kPadding12),
            decoration: BoxDecoration(
              border: Border.all(color: kColorWhite),
              borderRadius: BorderRadius.circular(kPadding16),
            ),
            child: Text(
              types,
              style: context.workSans(color: kColorWhite, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ],
    );
  }

  Widget _infoDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding24),
      width: Get.width,
      height: Get.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _infoSelector(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kPadding16),
              child: _infoContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSelector(BuildContext context) {
    return Row(
      children: [
        _infoSelectorContent(context, index: 0, title: 'About'),
        _infoSelectorContent(context, index: 1, title: 'Abilities'),
        _infoSelectorContent(context, index: 2, title: 'Moves'),
      ],
    );
  }

  Widget _infoSelectorContent(BuildContext context, {required int index, required String title}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _controller.onTapInfo(index: index),
        child: Container(
          padding: EdgeInsets.only(bottom: kPadding12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: _controller.selectedIndex.value != index
                      ? Colors.grey.withValues(alpha: 0.3)
                      : Colors.blueAccent),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _infoContent(BuildContext context) {
    switch (_controller.selectedIndex.value) {
      case 0:
        return _infoAbout(context);

      case 1:
        return _infoAbilities(context);

      case 2:
        return _infoMoves(context);

      default:
        return IgnorePointer();
    }
  }

  Widget _infoAbout(BuildContext context) {
    return Column(
      children: [
        _infoContentRow(context, title: 'Height', desc: '${_controller.model.value.height}'),
        _infoContentRow(context, title: 'Width', desc: '${_controller.model.value.weight}'),
        _infoContentRow(context, title: 'Base Experience', desc: '${_controller.model.value.baseExperience}'),
      ],
    );
  }

  Widget _infoContentRow(BuildContext context, {required String title, required String desc}) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: kPadding24),
            Expanded(
              flex: 3,
              child: Text(
                title,
              ),
            ),
            Text(':'),
            SizedBox(width: kPadding8),
            Expanded(
              flex: 6,
              child: Text(desc),
            ),
          ],
        ),
        SizedBox(height: kPadding8),
      ],
    );
  }

  Widget _infoAbilities(BuildContext context) {
    return Column(
      children: [
        for (String temp in _controller.model.value.abilities) ...[
          Container(
            margin: EdgeInsets.only(bottom: kPadding16),
            padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding24),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(kPadding16),
            ),
            child: Row(
              children: [
                Image.asset(
                  kImageSword,
                  width: kPadding20,
                  height: kPadding20,
                ),
                SizedBox(width: kPadding16),
                Text(
                  temp,
                  style: context.workSans(fontSize: kPadding16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _infoMoves(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 7,
        mainAxisSpacing: kPadding8,
        crossAxisSpacing: kPadding8,
      ),
      shrinkWrap: true,
      itemCount: _controller.model.value.moves.length,
      itemBuilder: (context, index) {
        String temp = _controller.model.value.moves[index];

        return Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: kPadding8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(kPadding12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.run_circle_outlined,
                color: Colors.black,
                size: kPadding20,
              ),
              SizedBox(width: kPadding12),
              Text(temp),
            ],
          ),
        );
      },
    );
  }

  Widget _background() {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          color: _controller.getColor(),
        ),
        Positioned(
          right: 24,
          child: Image.asset(
            kImagePokeball,
            width: 200,
            height: 200,
            opacity: const AlwaysStoppedAnimation(0.1),
          ),
        ),
      ],
    );
  }
}
