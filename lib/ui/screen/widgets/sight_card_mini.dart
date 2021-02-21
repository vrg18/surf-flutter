import 'package:flutter/material.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/shell_screens.dart';
import 'package:places/ui/screen/sight_detail/sight_detail.dart';
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
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
                  child: SizedBox.expand(
                    child: Image.network(
                      _sight.url,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
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
                MaterialPageRoute(
                  builder: (_) => context.read<Web>().isWeb ? ShellScreens(SightDetail(_sight)) : SightDetail(_sight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
