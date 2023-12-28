import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/common/models/drawer_item.dart';

class AppDrawer extends StatelessWidget {
  final String username;
  final List<DrawerItem> drawerItems;

  const AppDrawer({
    super.key,
    required this.username,
    required this.drawerItems,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          for (var item in drawerItems)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: item.onTap,
            ),
        ],
      ),
    );
  }
}
