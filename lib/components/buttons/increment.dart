import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncrementButton extends StatelessWidget {

  final void Function()? onPressed;

  IncrementButton({Key? key, this.onPressed}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
