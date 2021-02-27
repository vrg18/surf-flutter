import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

class NewSightPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 120,
      padding: const EdgeInsets.symmetric(vertical: basicBorderSize),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: basicBorderSize),
            decoration: BoxDecoration(
              border: Border.all(
                color: bigGreenButtonColor,
              ),
              borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
            ),
            child: Icon(Icons.add),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
//            scrollDirection: Axis.horizontal,
                children: [
                  buildContainer(),
                  buildContainer(),
                  buildContainer(),
                  buildContainer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.only(right: basicBorderSize),
      decoration: BoxDecoration(
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      ),
    );
  }
}
