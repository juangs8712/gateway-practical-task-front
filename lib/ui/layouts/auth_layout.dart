import 'package:flutter/material.dart';

import 'package:gateway/ui/layouts/widgets/background_gmaocxi.dart';
import 'package:gateway/ui/layouts/widgets/custom_title.dart';
import 'package:gateway/ui/layouts/widgets/links_bar.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
      // isAlwaysShown: true,
      child: ListView(physics:const ClampingScrollPhysics(), children: <Widget>[
        (size.width > 1000)
            ? _DesktopBody(child: child)
            : _MobileBody(child: child),
        // LinksBar
       const LinksBar()
      ]),
    ));
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        const SizedBox(height: 20),
        const CustomTitle(),
        //

        SizedBox(
          width: double.infinity,
          height: 450,
          child: child,
        ),
        //

        const SizedBox(
          width: double.infinity,
          height: 400,
          child: BackgroundFondoPc(),
        )
      ]),
    );
  }
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      decoration: const BoxDecoration(color: Colors.black),
      child: Row(children: <Widget>[

        //CXI background
        const Expanded(child: BackgroundFondoPc()),
        
        // View Container
        Container(
          width: 600,
          height: double.infinity,
          color: Colors.black,
          child: Column(children: <Widget>[
            const CustomTitle(),
            const SizedBox(height: 50),
            Expanded(child: child)
          ]),
        ),
        
      ]),
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~