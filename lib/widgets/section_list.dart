import 'package:flutter/material.dart';

import 'empty_state.dart';

class SectionList<T> extends StatelessWidget {
  const SectionList({
    super.key,

    required this.items,
    required this.itemBuilder,
    this.emptyMessage,
    this.emptyIcon,
    this.itemSpacing = 8,
  });


  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;

  final String? emptyMessage;
  final IconData? emptyIcon;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        const SizedBox(height: 8),

        const Divider(),

        const SizedBox(height: 8),

        Expanded(
          child: items.isEmpty && emptyMessage != null
              ? EmptyState(
            message: emptyMessage!,
            icon: emptyIcon ?? Icons.inbox_outlined,
          )
              : ListView.separated(
            itemCount: items.length,

            itemBuilder: (context, index) {
              return itemBuilder(
                context,
                items[index],
              );
            },

            separatorBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: itemSpacing),
                  const Divider(),
                  SizedBox(height: itemSpacing),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}