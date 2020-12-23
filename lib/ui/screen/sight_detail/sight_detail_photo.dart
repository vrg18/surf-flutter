import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/themes.dart';

/// Виджет - часть с фотографией места на экране детализации
class SightDetailPhoto extends StatelessWidget {
  final String _url;

  SightDetailPhoto(this._url);

  @override
  Widget build(BuildContext context) {
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
              color: currentThemeIsDark ? dmMainBackgroundColor : lmMainBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => print(toLeftPress),
                child: Icon(
                  Icons.chevron_left,
                  color: currentThemeIsDark ? dmElementPrimaryColor : lmElementPrimaryColor,
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
