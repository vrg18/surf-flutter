import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';

class SightDetailPhoto extends StatelessWidget {
  late String _url;

  SightDetailPhoto(this._url);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox.expand(
        child: Image.network(
          _url,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Icon(
          Icons.chevron_left,
          color: primaryTextColor,
          size: 28,
        ),
      )
    ]);
  }
}
