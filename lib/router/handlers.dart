import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gateway/bloc/menu/menu_bloc.dart';
import 'package:gateway/router/router.dart';
import 'package:gateway/ui/views/gateway_detail_view.dart';

import 'package:gateway/ui/views/peripheral_view.dart';
import 'package:gateway/ui/views/dashboard_view.dart';
import 'package:gateway/ui/views/no_page_found_view.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class DashboardHandlers {
// -----------------------------------------------------
  static Handler gateway = Handler(handlerFunc: (context, params) {
    BlocProvider.of<MenuBloc>(context!).add( SetPageMenuEvent( Flurorouter.rootRoute ) );
    return const DashboardView();
  });
  
// -----------------------------------------------------
  static Handler peripheral = Handler(handlerFunc: (context, params) {
    BlocProvider.of<MenuBloc>(context!).add( SetPageMenuEvent( Flurorouter.peripheralRoute ) );
    return const PeripheralView();
  });
// -----------------------------------------------------
  static Handler gatewayDetail = Handler(handlerFunc: (context, params) {
    BlocProvider.of<MenuBloc>(context!).add( SetPageMenuEvent( Flurorouter.peripheralRoute ) );
    return const GatewayDetailView();
  });
// -----------------------------------------------------

  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    BlocProvider.of<MenuBloc>(context!).add( SetPageMenuEvent( '' ) );
    return const NoPageFoundView();
  });
// -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~