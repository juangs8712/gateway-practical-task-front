import 'package:flutter/material.dart';

import 'package:gateway/ui/labels/custom_labels.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key, 
    required this.title,
    required this.onAddEditTap,
    required this.onRefreshTap, 
  });

  final String title;
  final void Function()? onAddEditTap;
  final void Function()? onRefreshTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox( width: 10,),
        Expanded(child: Text( title, style: CustomLabels.h1 )),

        // Refresh button
        IconButton(
          splashRadius: 15,
          onPressed: onRefreshTap,
          icon: const Icon( 
            Icons.refresh_outlined, 
            size: 30, 
            color: Color(0xFF596B7A), )),

        // Add button
        IconButton(
          splashRadius: 15,
          onPressed: onAddEditTap, 
          icon: const Icon( 
            Icons.add_circle, 
            size: 30, 
            color: Color(0xFF596B7A), )),
        const SizedBox( width: 15, )
      ],
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~