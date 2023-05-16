import 'package:flutter/material.dart';

import 'package:gateway/bloc/menu/menu_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gateway/ui/shared/navbar.dart';
import 'package:gateway/ui/shared/sidebar.dart';


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class DashboardLayout extends StatelessWidget {
  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final menuState = BlocProvider.of<MenuBloc>(context, listen: true).state;
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xffEDF1F2),
        body: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (size.width >= 700) const Sidebar(),
        
                  // contenedor de nuestra view
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        const NavBar(),
                        
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 5, vertical: 10), 
                          child: child,)
                        ),
                      ],
                    ),
                  )
                ],
              ),
        
              if (size.width < 700)
                AnimatedBuilder(
                  animation: menuState.menuController,
                  builder: (context, _) => Stack(
                    children: <Widget>[
        
                      if ( menuState.isOpen )
                        Opacity(
                          opacity: menuState.opacity.value,
                          child: GestureDetector(
                            onTap: ()=> context.read<MenuBloc>().add(CloseMenuEvent()),
                            child: Container(
                              width: size.width,
                              height: size.height,
                              color: Colors.black26,
                            ),
                          ),
                        ),
        
                      // animacion para mostrar el menu
                      Transform.translate(
                        offset: Offset( menuState.movement.value, 0),
                        child: const Sidebar(),
                      )
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
