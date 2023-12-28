// sidebar_menu_item_widget.dart

import 'package:flutter/material.dart';

import '../models/sidebar.dart';

class SidebarMenuItem extends StatelessWidget {
  final SidebarMenuItemModel item;

  const SidebarMenuItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          // You can add more styling properties here
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                item.icon,
                size: 24,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
