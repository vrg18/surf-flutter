import 'package:flutter/cupertino.dart';

class MyFirstStatelessWidget extends StatelessWidget {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    print('Stateless: ${++_count}');
    return Container(
      child: Center(
        child: Text('Hello! (Stateless)'),
      ),
    );
  }
}
