import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/themes.dart';

/// Виджет - часть с фотографией места на экране детализации
class SightDetailPhoto extends StatelessWidget {
  final String _url;

  SightDetailPhoto(this._url);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: currentThemeIsDark ? dmMainBackgroundColor : lmMainBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Icon(
          Icons.chevron_left,
          color: currentThemeIsDark ? dmElementPrimaryColor : lmElementPrimaryColor,
          size: 28,
        ),
      )
    ]);
  }
}