import 'package:flutter/material.dart';

import 'package:gateway/models/peripheral_model.dart';
import 'package:gateway/ui/views/peripheral_widgets.dart/peripheral_icon.dart';
import 'package:gateway/ui/views/peripheral_widgets.dart/status_widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class PeripheralWidget extends StatelessWidget {
  const PeripheralWidget({
    super.key, 
    required this.peripheral, 
    required this.onEditPressed, 
    required this.onDeletePressed
  });

  final Peripheral peripheral;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text( 'UID: ${peripheral.uid}' ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5,),
              Text( 'Vendor: ${peripheral.vendor}' ),
              const SizedBox(height: 5,),
              Text( 'Date: ${peripheral.date}' ),
              const SizedBox(height: 5,),
              StatusWidget(status: peripheral.status),
              const SizedBox(height: 5,),
              Text( 'Gateway: ${peripheral.gateway.name}' ),
            ],
          ),
          leading: PeripheralIcon(index:  peripheral.uid ?? -1 ),
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
        ),
        const Divider()
      ],
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
