import 'package:fluro/fluro.dart';

import 'package:gateway/router/handlers.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute           = '/';
  static String peripheralRoute     = '/peripheral';
  static String gatewayDetailRoute  = '/gateway-detail';

  // Configure routes
  // -----------------------------------------------------
  static void configureRoute() {
    // rootRoute 
    router.define( 
      rootRoute,       
      handler: DashboardHandlers.gateway, 
      transitionType: TransitionType.fadeIn );

    // peripheralRoute
    router.define( 
      peripheralRoute, 
      handler: DashboardHandlers.peripheral,     
      transitionType: TransitionType.fadeIn );

    // peripheralRoute
    router.define( 
      gatewayDetailRoute, 
      handler: DashboardHandlers.gatewayDetail,     
      transitionType: TransitionType.fadeIn );

    // 404 - Not page Found
    router.notFoundHandler = DashboardHandlers.noPageFound;
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
