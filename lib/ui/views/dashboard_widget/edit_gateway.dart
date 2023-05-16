import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/bloc/gateway/gateway_bloc.dart';

import 'package:gateway/models/gateway_model.dart';
import 'package:gateway/providers/gateway_provider.dart';
import 'package:gateway/services/navigation_service.dart';

import 'package:gateway/ui/buttons/custom_outlined_button.dart';
import 'package:gateway/ui/dialogs/custom_dialogs.dart';
import 'package:gateway/ui/inputs/custom_inputs_decorations.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class EditGateWay extends StatefulWidget {
  const EditGateWay({
    super.key, 
    this.gateway
  });

  final Gateway? gateway;
  @override
  State<EditGateWay> createState() => _EditGateWayState();
}

class _EditGateWayState extends State<EditGateWay> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final ipv4Ctrl = TextEditingController();
  late final bool isNewGateway;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    isNewGateway = widget.gateway == null;
    if ( ! isNewGateway ) {
      nameCtrl.text = widget.gateway!.name;
      ipv4Ctrl.text = widget.gateway!.ipv4;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Divider(),
            TextFormField(
              controller: nameCtrl,
              decoration: CustomInputDecorations.rectInputDecoration(
                hint: 'Gateway name', 
                label: 'Name', ),
              validator: (value) => 
                (value ?? '').isEmpty ? "The name can't be empty." : null ,
            ),

            const SizedBox( height: 30,),
            TextFormField(
              controller: ipv4Ctrl,
              decoration: CustomInputDecorations.rectInputDecoration(
                hint: 'IPv4 address', 
                label: 'IPv4', ),
              validator: (value) => 
                (value ?? '').isEmpty ? "The IPv4 address can't be empty." : null ,
            ),

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
                    onPressed: _onAccept ),
            
                  const SizedBox( width: 20,),
                  CustomOutlinedButton(
                    text: 'Cancel',
                    onPressed: ()=> NavigationService.pop() ),
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
      '_id' : widget.gateway?.id ?? '',
      'name': nameCtrl.text,
      'ipv4': ipv4Ctrl.text
    };

    try {
      final gatewayBloc = BlocProvider.of<GatewayBloc>( context );
      setState(()=> loading = true);
      if ( isNewGateway ) {
        await GatewayProvider.post( Gateway.fromJson(json) );
      }else{
        await GatewayProvider.put( Gateway.fromJson(json) );
      }
      gatewayBloc.add( GatewayGetListEvent() );
      NavigationService.pop();
    } catch (e) {
      CustomDialogs.dialogBuilder(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( e.toString() ),
            TextButton(
              onPressed: ()=>NavigationService.pop(), 
              child: const Text( 'Accept' ))
          ],
        ));
    }finally{
      setState( ()=> loading = false );
    }
  }
// -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~