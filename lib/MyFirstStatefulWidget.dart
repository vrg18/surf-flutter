import 'package:flutter/cupertino.dart';

class MyFirstStatefulWidget extends StatefulWidget {

  @override
  createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  int _count = 0;

  _MyFirstStatefulWidgetState();

  @override
  Widget build(BuildContext context) {
    print('Stateful: ${++_count}');
    return Container(
      child: Center(
        child: Text('Hello! (Stateful)'),
      ),
    );
  }
}
