import 'package:flutter/material.dart';
import 'package:gateway/models/gateway_model.dart';
import 'package:gateway/router/router.dart';
import 'package:gateway/services/navigation_service.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class GatewayWidget extends StatelessWidget {
  const GatewayWidget({
    super.key, 
    required this.gateway, 
    required this.onEditPressed, 
    required this.onDeletePressed
  });

  final Gateway gateway;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile( 
          title: Text( gateway.name ),
          subtitle: Text( gateway.ipv4 ),
          leading: const CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon( 
              Icons.switch_access_shortcut, 
              color: Colors.black54,)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit Icon
              IconButton(
                splashRadius: 25,
                onPressed: onEditPressed, 
                icon: const Icon( Icons.edit_outlined )),

              // Delete icon
              IconButton(
                splashRadius: 25,
                onPressed: onDeletePressed, 
                icon: const Icon( Icons.delete_forever_outlined, color: Colors.redAccent, )),
            ],
          ),
          onTap: ()=> NavigationService.navigateTo( 
            Flurorouter.gatewayDetailRoute, arguments: gateway )
        ),

        const Divider()
      ],
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~