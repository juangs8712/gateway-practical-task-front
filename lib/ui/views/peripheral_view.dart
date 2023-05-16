import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/bloc/peripheral/peripheral_bloc.dart';
import 'package:gateway/models/peripheral_model.dart';
import 'package:gateway/providers/peripheral_provider.dart';

import 'package:gateway/ui/cards/white_card.dart';
import 'package:gateway/ui/dialogs/custom_dialogs.dart';
import 'package:gateway/ui/views/peripheral_widgets.dart/edit_peripheral.dart';
import 'package:gateway/ui/views/peripheral_widgets.dart/peripheral_widget.dart';
import 'package:gateway/ui/views/widgets/navigation_button_widget.dart';
import 'package:gateway/ui/views/widgets/page_header.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class PeripheralView extends StatelessWidget {
  const PeripheralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeripheralBloc, PeripheralState>(
      builder: (context, state) {
        // Check if loading.
        if ( state.loading ) {
          return const Center(child: CircularProgressIndicator(),);
        }

        // Check for any error and display it if needed.
        if ( state is PeripheralStateError ) {
          final msg = state.error;
          context.read<PeripheralBloc>().add( PeripheralClearErrorEvent() );
          CustomDialogs.dialogBuilder(content: Text( msg ));
        }

        // Otherwise display the view contain.
        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 650,

              child: ListView(
                children: [
                  PageHeader(
                    title: 'Peripheral',
                    onAddEditTap: _onAddEdit,
                    onRefreshTap: ()=>
                    context.read<PeripheralBloc>()
                      .add( PeripheralGetListEvent() ), ),
                      
                  WhiteCard( 
                    title: 'Peripheral List', 
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: state.items.map(( peripheral ) => 
                        PeripheralWidget( 
                          peripheral: peripheral, 
                          onEditPressed: ()=> 
                              _onAddEdit( peripheral: peripheral ),
                          onDeletePressed: ()=> 
                            _onDelete( context, peripheral.id! ), 
                        )).toList(),
                    ) ),
                ],
              ),
            ),
          ),

          // Navigation Widget
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: NavigationButtonsWidget(
            skip: state.skip,
            total: state.total,
            onTapBackward: () => context.read<PeripheralBloc>()
              .add( PeripheralBackwardEvent() ),
            onTapFordward: () => context.read<PeripheralBloc>()
              .add( PeripheralForwardEvent() ), ),
        );
      },
    );
  }
  
  // -----------------------------------------------------
  void _onAddEdit({ Peripheral? peripheral }){
    CustomDialogs.dialogBuilder(
      title: Row(
        children: [
          Icon( peripheral == null 
            ? Icons.add_circle_outline
            : Icons.mode_edit_outlined ),
          const SizedBox( width: 20,),
          Expanded(
            child: Text( peripheral == null 
              ? 'Add peripheral' : 'Edit peripheral' )),
        ],
      ),
      content: EditPeripheral( peripheral: peripheral ));
  }
  // -----------------------------------------------------
  void _onDelete( BuildContext context, String id ) async {
    final peripheral = BlocProvider.of<PeripheralBloc>(context);
    await PeripheralProvider.delete(id);
    peripheral.add( PeripheralGetListEvent() );
  }
  // -----------------------------------------------------
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
