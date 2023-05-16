import 'package:flutter/material.dart';

class NavBarAvatar extends StatelessWidget {
  const NavBarAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClipOval(
      child: SizedBox(
        width:  30,
        height: 30,
        child: Icon(Icons.person_outline )
      ),
    );
  }
}