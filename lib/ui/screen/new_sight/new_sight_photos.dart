import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

class NewSightPhotos extends StatelessWidget {
  final List<String> _photos;

  NewSightPhotos(this._photos);

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
                child: InkWell(
                  onTap: () => print('============'),
                  child: Container(
                    width: 80,
                    height: 80,
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
                children: [
                  photoContainer(Random().nextInt(0xFFFFFF).toRadixString(16)),
                  photoContainer(Random().nextInt(0xFFFFFF).toRadixString(16)),
                  photoContainer(Random().nextInt(0xFFFFFF).toRadixString(16)),
                  photoContainer(Random().nextInt(0xFFFFFF).toRadixString(16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container photoContainer(String photo) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Color(int.parse(photo, radix: 16)).withOpacity(1.0),
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      ),
    );
  }
}
