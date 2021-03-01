import 'package:flutter/material.dart';
import 'package:places/ui/res/sizes.dart';

class MiniPhoto extends StatelessWidget {
  final String _photoUrl;

  MiniPhoto(this._photoUrl);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
        child: _photoUrl.substring(0, 4) != 'http'
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
      ),
    );
  }
}
