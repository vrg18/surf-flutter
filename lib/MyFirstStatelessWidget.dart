import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFirstStatelessWidget extends StatelessWidget {
  int _count = 0;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    print('Stateless: ${++_count}');
    return Container(
        child: Column(
      children: [
        Text('Hello! (Stateless)'),
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
