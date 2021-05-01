import 'package:flutter/material.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:places/ui/screen/sight_detail/sight_detail.dart';
import 'package:places/ui/screen/widgets/mini_photo.dart';
import 'package:places/ui/screen/widgets/slide_on_right_route.dart';
import 'package:provider/provider.dart';

class SightCardMini extends StatelessWidget {
  final Sight _sight;

  SightCardMini(this._sight);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      child: Stack(
        children: [
          Row(
            children: [
              MiniPhoto(_sight.photos[0]),
              const SizedBox(width: basicBorderSize),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _sight.name,
                    style: sightMiniCardTitleStyle,
                  ),
                  Text(
                    _sight.category.toString(),
                    style: lightFaintInscriptionStyle,
                  ),
                ],
              )
            ],
          ),
          Positioned.fill(
            child: MaterialButton(
              onPressed: () => Navigator.push(
                context,
                SlideOnRightRoute(
                    page: context.read<Web>().isWeb ? WebWrapper(SightDetail(_sight.id!)) : SightDetail(_sight.id!)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
