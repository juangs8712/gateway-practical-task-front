import 'package:flutter/material.dart';
import 'package:gateway/ui/views/dashboard_widget/detail_header_widget.dart';
import 'package:gateway/ui/views/peripheral_widgets.dart/peripheral_icon.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:gateway/models/gateway_model.dart';
import 'package:gateway/providers/peripheral_provider.dart';
import 'package:gateway/services/navigation_service.dart';

import 'package:gateway/ui/cards/white_card.dart';
import 'package:gateway/ui/views/peripheral_widgets.dart/status_widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class GatewayDetailView extends StatelessWidget {
  const GatewayDetailView({
    super.key, 
    });

  @override
  Widget build(BuildContext context) {
    final gateway = ModalRoute.of(context)!.settings.arguments as Gateway;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 650,
          child: ListView(
            padding: const EdgeInsets.symmetric( horizontal: 5 ),
            children: [
              // back button
              InkWell(
                child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    const Icon( Icons.arrow_back, size: 18, color: Colors.blueAccent, ),
                    Text( 'Back', style: GoogleFonts.poppins( color: Colors.blueAccent), )
                  ],
                ),
                onTap: ()=>NavigationService.pop(),
              ),

              // View's header
              DetailHeaderWidget( 
                child: ListTile(
                  title: Text( 'Name: ${gateway.name}' ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( 'IPv4 address: ${gateway.ipv4}' ),
                      Text( 'ID: ${gateway.id}' ),
                    ],
                  ),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: Icon( 
                      Icons.switch_access_shortcut, 
                      color: Colors.black54,
                    )
                  )
                ),
              ),
          
              // List of associated devices
              WhiteCard(
                title: 'Associated devices to the gateway',
                child: FutureBuilder(
                  future: PeripheralProvider.getPeripheralsByGateway( gateway.id! ),
                  builder: ( context, snapshot) {
                    if ( snapshot.hasError ) {
                      return Center( child: Text( snapshot.error.toString() ),);
                    }
                    if ( ! snapshot.hasData ) {
                      return const Center( child: CircularProgressIndicator() );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.data!.map((peripheral) => 
                        ListTile(
                          title: Text( 'UID: ${peripheral.uid}'  ),
                          leading: PeripheralIcon(index:  peripheral.uid ?? -1 ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5,),
                              Text( 'Vendor: ${peripheral.vendor}' ),
                              const SizedBox(height: 5,),
                              Text( 'Date: ${peripheral.date}' ),
                              const SizedBox(height: 5,),
                              StatusWidget(status: peripheral.status),
                              const SizedBox(height: 5,),
                              Text( 'Gateway: ${peripheral.gateway.name}' ),
                              const Divider(),
                            ],
                          ),
                        )
                      ).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~