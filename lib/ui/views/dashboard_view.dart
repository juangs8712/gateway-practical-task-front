import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gateway/bloc/gateway/gateway_bloc.dart';
import 'package:gateway/models/gateway_model.dart';
import 'package:gateway/providers/gateway_provider.dart';
import 'package:gateway/ui/cards/white_card.dart';

import 'package:gateway/ui/dialogs/custom_dialogs.dart';
import 'package:gateway/ui/views/dashboard_widget/gateway_widget.dart';
import 'package:gateway/ui/views/dashboard_widget/edit_gateway.dart';
import 'package:gateway/ui/views/widgets/navigation_button_widget.dart';
import 'package:gateway/ui/views/widgets/page_header.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GatewayBloc, GatewayState>(
      builder: ( context, state) { 
        // Check if loading.
        if ( state.loading ) {
          return const Center(child: CircularProgressIndicator(),);
        }

        // Check for any error and display it if needed.
        if ( state is GatewayStateError ) {
          final msg = state.error;
          context.read<GatewayBloc>().add( GatewayClearErrorEvent() );
          CustomDialogs.dialogBuilder( content: Text( msg ) );
        }

        // Otherwise display the view contain.
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SizedBox(
              width: 650,
              child: ListView(
                padding: const EdgeInsets.symmetric( horizontal: 5 ),
                children: [
                  PageHeader(
                    title: 'Gateway',
                    onAddEditTap: _onAddEdit,
                    onRefreshTap: ()=> context.read<GatewayBloc>()
                      .add( GatewayGetListEvent() ), ),
                  
                  // Display the gateway list.
                  WhiteCard(
                    title: 'Gateway List',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...state.items.map((gateway) => GatewayWidget(
                            gateway: gateway, 
                            onEditPressed: ()=> 
                              _onAddEdit( gateway: gateway ), 
                            onDeletePressed: ()=> 
                              _onDelete( context, gateway.id! ), )).toList(),
                        const SizedBox( height: 40, )
                      ],
                    ),
                  ),
                  
                  
                ],
              ),
            ),
          ),

          // Navigation Widget
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: NavigationButtonsWidget(
            skip: state.skip,
            total: state.total,
            onTapBackward: () => context.read<GatewayBloc>()
              .add( GatewayBackwardEvent() ),
            onTapFordward: () => context.read<GatewayBloc>()
              .add( GatewayForwardEvent() ), ),  
        );
      },
    );
  }
  // -----------------------------------------------------
  void _onAddEdit({ Gateway? gateway }){
    CustomDialogs.dialogBuilder(
      title: Row(
        children: [
          Icon( gateway == null 
            ? Icons.add_circle_outline
            : Icons.mode_edit_outlined ),
          const SizedBox( width: 20,),
          Expanded(
            child: Text( gateway == null 
              ? 'Add gateway' : 'Edit gateway' )),
        ],
      ),
      content: EditGateWay( gateway: gateway ));
  }
  // -----------------------------------------------------
  void _onDelete( BuildContext context, String id ) async {
    final gatewayBloc = BlocProvider.of<GatewayBloc>(context);
    await GatewayProvider.delete(id);
    gatewayBloc.add( GatewayGetListEvent() );
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
