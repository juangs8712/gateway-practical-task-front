import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gateway/bloc/menu/menu_bloc.dart';

import 'widget/navbar_avatar.dart';
import 'widget/notifications_indicator.dart';
import 'widget/search_text.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: _builBoxDecoration(),
      child: Row(children: <Widget>[
        if( size.width <= 700 )
        IconButton(
          onPressed: () => context.read<MenuBloc>().add( OpenMenuEvent() ), 
          icon: const Icon(Icons.menu_outlined)
        ),

        const SizedBox(width: 5),

        // Search input
        if(size.width > 390)
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: const SearchText()),

        const Spacer(),
        const NotificationsIndicator(),

        const SizedBox(width: 10),
        const NavBarAvatar(),

        const SizedBox(width: 10),
      ]),
    );
  }

  // -----------------------------------------------------
  BoxDecoration _builBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~