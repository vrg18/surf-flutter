import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

class NewSightPhotos extends StatefulWidget {
  final List<String> _photos;

  NewSightPhotos(this._photos);

  @override
  _NewSightPhotosState createState() => _NewSightPhotosState();
}

class _NewSightPhotosState extends State<NewSightPhotos> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(basicBorderSize),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: basicBorderSize),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () => _addPhoto(),
                  child: Container(
                    width: photoSizeOfNewSight,
                    height: photoSizeOfNewSight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: bigGreenButtonColor,
                      ),
                      borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 48,
                      color: bigGreenButtonColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: basicBorderSize,
                children: widget._photos.map((e) => _photoContainer(e)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoContainer(String photo) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: photoSizeOfNewSight,
          height: photoSizeOfNewSight,
          decoration: BoxDecoration(
            color: Color(int.parse(photo, radix: 16)).withOpacity(1.0),
            borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
            child: SizedBox(
              width: 48,
              child: MaterialButton(
                onPressed: () => _deletePhoto(photo),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                height: 48,
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addPhoto() {
    setState(() =>
        widget._photos.add(Random().nextInt(0xFFFFFF).toRadixString(16))); // todo временно цветная заглушка вместо фото
  }

  void _deletePhoto(String photo) {
    setState(() => widget._photos.remove(photo));
  }
}
