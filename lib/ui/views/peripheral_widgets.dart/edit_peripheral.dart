import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/bloc/gateway/gateway_bloc.dart';
import 'package:gateway/bloc/peripheral/peripheral_bloc.dart';

import 'package:gateway/models/gateway_model.dart';
import 'package:gateway/models/peripheral_model.dart';
import 'package:gateway/providers/peripheral_provider.dart';
import 'package:gateway/services/navigation_service.dart';

import 'package:gateway/ui/dialogs/custom_dialogs.dart';
import 'package:gateway/ui/buttons/custom_outlined_button.dart';
import 'package:gateway/ui/inputs/custom_inputs_decorations.dart';
import 'package:google_fonts/google_fonts.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const statusList = ['online', 'offline'];
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class EditPeripheral extends StatefulWidget {
  const EditPeripheral({
    super.key, 
    this.peripheral
  });

  final Peripheral? peripheral;
  @override
  State<EditPeripheral> createState() => _EditGateWayState();
}

class _EditGateWayState extends State<EditPeripheral> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final vendorCtrl = TextEditingController();
  late final bool isNewPeripheral;
  bool loading = false;
  String? status;
  Gateway? gateway;

  @override
  void initState() {
    super.initState();
    isNewPeripheral = widget.peripheral == null;
    if ( ! isNewPeripheral ) {
      vendorCtrl.text = widget.peripheral!.vendor;
    }
  }
  @override
  Widget build(BuildContext context) {
      final gatewayItems = BlocProvider
        .of<GatewayBloc>(context, listen: true)
        .state.items;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor name
            TextFormField(
              controller: vendorCtrl,
              decoration: CustomInputDecorations.rectInputDecoration(
                hint: 'Peripheral vendor', 
                label: 'Vendor', ),
              validator: (value) => 
                (value ?? '').isEmpty ? "The vendor can't be empty." : null ,
            ),

            // Gateway list
            const SizedBox( height: 25,),
            DropdownButtonFormField<Gateway>(
              decoration: CustomInputDecorations.rectInputDecoration(
                label: 'Pick a gateway',
                hint: 'Gateways' ),
              items: gatewayItems.map(( value ) =>
                DropdownMenuItem(
                  value: value,
                  child: Text( value.name )) ).toList(), 
              onChanged: (value)=> 
                setState(()=> gateway = value),
              validator: _onValidatedGateway,),

            if( widget.peripheral != null )
              _CurrentValueWidget(value: widget.peripheral!.gateway.name),

            // Status list
            const SizedBox( height: 25,),
            DropdownButtonFormField<String>(
              decoration: CustomInputDecorations.rectInputDecoration(
                label: 'Pick a status',
                hint: 'Status' ),
              items: statusList.map((str) => 
                DropdownMenuItem(
                  value: str,
                  child: Text( str )))
                .toList(), 
              onChanged: (value)=>setState(()=>status = value!),
              validator: _onValidatedStatus,),

            if( widget.peripheral != null )
              _CurrentValueWidget(value: widget.peripheral!.status),

            // Accept and Cancel Buttons
            const Divider( height: 40,),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomOutlinedButton(
                    text: 'Accept',
                    isLoading: loading,
                    onPressed: _onAccept,),
            
                  const SizedBox( width: 20,),
                  CustomOutlinedButton(
                    text: 'Cancel',
                    onPressed: ()=> NavigationService.pop()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
// -----------------------------------------------------
  void _onAccept() async {
    if ( !formKey.currentState!.validate() ) {
      return;
    }
    final json = <String, dynamic>{ 
      '_id' : widget.peripheral?.id ?? '',
      'vendor': vendorCtrl.text, 
    };
    if ( isNewPeripheral || gateway != null ) {
      json.addAll({
        'gateway' :<String, dynamic>{ 
          '_id'   : gateway!.id,
          'name' : gateway!.name
        }
      });
    }
    
    if ( isNewPeripheral || status != null ) {
      json['status'] = status!;
    }
    try {
      final peripheralBloc = BlocProvider.of<PeripheralBloc>( context );
      setState(()=> loading = true);
      if ( isNewPeripheral ) {
        await PeripheralProvider.post( Peripheral.fromJson(json) );
      }else{
        await PeripheralProvider.put( json );
      }
      peripheralBloc.add( PeripheralGetListEvent() );
      NavigationService.pop();
    } catch (e) {
      CustomDialogs.dialogBuilder(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( e.toString() ),
            TextButton(
              onPressed: ()=>NavigationService.pop(), 
              child: const Text( 'Accept' ) )
          ],
        ));
    }finally{
      setState( ()=> loading = false );
    }
  }
// -----------------------------------------------------
String? _onValidatedGateway( Gateway? value ){
  if ( isNewPeripheral && value == null ) {
    return 'Pick a gateway, please.';
  }
  return null;
}
// -----------------------------------------------------
String? _onValidatedStatus( String? value ){
  if ( isNewPeripheral && value == null ) {
    return 'Pick a status, please.';
  }
  return null;
}
// -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class _CurrentValueWidget extends StatelessWidget {
  const _CurrentValueWidget({
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text( 
      'Current: $value',
      style: GoogleFonts.poppins( 
        color: Colors.grey,
        fontWeight: FontWeight.w400), );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~