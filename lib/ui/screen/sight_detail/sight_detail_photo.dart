import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:provider/provider.dart';

/// Верхняя (левая) часть экрана детализации места с фотографией места
class SightDetailPhoto extends StatefulWidget {
  final List<String> _photoUrls;
  final double _indicatorWidth;

  SightDetailPhoto(this._photoUrls, this._indicatorWidth);

  @override
  _SightDetailPhotoState createState() => _SightDetailPhotoState();
}

class _SightDetailPhotoState extends State<SightDetailPhoto> {
  late PageController _controller;
  late double _offsetFromLeft;
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _offsetFromLeft = 0;
    _isDark = context.read<CurrentTheme>().isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget._photoUrls.length,
          itemBuilder: (context, index) => _picture(index),
          onPageChanged: _pageChanged,
        ),
        if (widget._photoUrls.length > 1)
          Positioned(
            bottom: 0,
            left: _offsetFromLeft,
            child: Container(
              height: heightOfPhotoIndicator,
              width: widget._indicatorWidth,
              decoration: BoxDecoration(
                color: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
                borderRadius: BorderRadius.circular(heightOfPhotoIndicator / 2),
              ),
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

  /// При смене картинки
  void _pageChanged(int index) {
    setState(() => _offsetFromLeft = widget._indicatorWidth * index);
  }

  /// Картинка места
  Widget _picture(int index) {
    return widget._photoUrls[index].substring(0, 4) != 'http'
        ? Container(
            // todo врем. цв. заглушки вместо фото
            color: Color(int.parse(widget._photoUrls[index], radix: 16)).withOpacity(1.0),
          )
        : SizedBox.expand(
            child: Image.network(
              widget._photoUrls[index],
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
          );
  }
}
