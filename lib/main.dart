import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:gateway/bloc/gateway/gateway_bloc.dart';

import 'package:gateway/bloc/menu/menu_bloc.dart';
import 'package:gateway/bloc/peripheral/peripheral_bloc.dart';
import 'package:gateway/router/router.dart';
import 'package:gateway/services/navigation_service.dart';
import 'package:gateway/services/share_prefs.dart';

import 'package:gateway/ui/layouts/dashboard_layout.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initPrefs();
  Flurorouter.configureRoute();

  runApp(const AppState());
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class AppState extends StatefulWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GatewayBloc() ),
          BlocProvider(create: (context) => PeripheralBloc() ),
          BlocProvider( create: ( context ) => MenuBloc( 
            menuController: AnimationController(
              vsync: this, 
              duration: const Duration(milliseconds: 300) ) ),) 
        ], 
        child: const MyApp());
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: Flurorouter.rootRoute,
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,

      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse, 
          PointerDeviceKind.touch, 
          PointerDeviceKind.stylus, 
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown,
        },
      ),
      theme: ThemeData.light().copyWith(
          scrollbarTheme:const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all( Colors.grey[500] ))),

      builder: ( context, child ) {
        return DashboardLayout(child: child!);
      },
      
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~