import 'package:flutter/material.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Icon(Icons.notifications_none_outlined, color: Colors.grey),
        Positioned(
          left: 2,
          child: Container(
            width: 5,
            height: 5,
            decoration: buildDecoration(),
          ),
        )
      ]
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(10)
  );
}