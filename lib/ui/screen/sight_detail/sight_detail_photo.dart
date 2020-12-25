import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings.dart';
import 'package:provider/provider.dart';

/// Верхняя (левая) часть экрана детализации места с фотографией места
class SightDetailPhoto extends StatelessWidget {
  final String _url;

  SightDetailPhoto(this._url);

  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<CurrentTheme>().isDark;

    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            _url,
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
        Positioned(
          left: 15,
          top: 30,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? darkMainBackgroundColor : lightMainBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => print(toLeftPress),
                child: Icon(
                  Icons.chevron_left,
                  color: isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
