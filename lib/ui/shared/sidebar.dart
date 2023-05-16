
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gateway/bloc/menu/menu_bloc.dart';
import 'package:gateway/services/navigation_service.dart';
import 'package:gateway/router/router.dart';

import 'package:gateway/ui/shared/widget/logo.dart';
import 'package:gateway/ui/shared/widget/menu_item.dart';
import 'package:gateway/ui/shared/widget/text_separator.dart';


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  void navigateTo( BuildContext context, String routeName){
    
    NavigationService.navigateTo(routeName);
    context.read<MenuBloc>().add( CloseMenuEvent() );
              
  }

  @override
  Widget build(BuildContext context) {
    final menuState = BlocProvider.of<MenuBloc>(context, listen: true).state;

    // final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: builBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          const Logo(),

          const SizedBox(height: 50),
          const TextSeparator(text: 'Main'),

          MyMenuItem(
            text: 'Gateways',
            icon: Icons.device_hub_outlined,
            onPressed: ()=>navigateTo( context, Flurorouter.rootRoute ),
            isActive: menuState.currentPage == Flurorouter.rootRoute,
            ),

          MyMenuItem(
            text: 'Peripherals',
            icon: Icons.devices_other_rounded,
            onPressed: ()=> navigateTo( context, Flurorouter.peripheralRoute ),
            isActive: menuState.currentPage == Flurorouter.peripheralRoute ),

          // MyMenuItem(
          //   text: 'Discount',
          //   icon: Icons.attach_money_outlined,
          //   onPressed: () {}),

        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  BoxDecoration builBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: <Color>[
        Color(0xff092044),
        Color(0xff092042),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
  // --------------------------------------------------------------------------
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
