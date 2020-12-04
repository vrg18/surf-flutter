import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFirstStatefulWidget extends StatefulWidget {

  @override
  createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  int _count = 0;
  late BuildContext _context;

  _MyFirstStatefulWidgetState();

  @override
  Widget build(BuildContext context) {
    this._context = context;
    print('Stateful: ${++_count}');
    return Container(
        child: Column(
          children: [
            Text('Hello! (Stateful)'),
            Container(
              color: Colors.blue,
              child: MaterialButton(
                child: Text('Tap on me for print\ncontext.runtimeType'),
                onPressed: () {
                  print(_getContextRuntimeType());
                },
              ),
            )
          ],
        ));
  }

  Type _getContextRuntimeType() {
    return _context.runtimeType;
  }
}
