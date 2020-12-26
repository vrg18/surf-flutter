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
    var _isDark = context.watch<CurrentTheme>().isDark;

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
          child: SizedBox(
            width: 36,
            height: 36,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: _isDark ? darkMainBackgroundColor : lightMainBackgroundColor,
                child: InkWell(
                  onTap: () => print(toLeftPress),
                  child: Icon(
                    Icons.chevron_left,
                    color: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
