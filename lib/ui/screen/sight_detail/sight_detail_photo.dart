import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:provider/provider.dart';

/// Верхняя (левая) часть экрана детализации места с фотографией места
class SightDetailPhoto extends StatelessWidget {
  final String _photoUrl;

  SightDetailPhoto(this._photoUrl);

  @override
  Widget build(BuildContext context) {
    var _isDark = context.watch<CurrentTheme>().isDark;

    return Stack(
      children: [
        _photoUrl.substring(0, 4) != 'http'
            ? Container(color: Color(int.parse(_photoUrl, radix: 16)).withOpacity(1.0)) // todo врем. заглушка
            : SizedBox.expand(
                child: Image.network(
                  _photoUrl,
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
                  onTap: () {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: _isDark ? Brightness.light : Brightness.dark,
                    ));
                    Navigator.pop(context);
                  },
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
