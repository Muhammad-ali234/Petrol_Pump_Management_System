import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Models/user.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Screens/all_transaction.dart';
import 'package:petrol_pump/Pump/Credit_Debit/Widgets/save_button.dart';
import 'package:petrol_pump/Pump/common/models/drawer_item.dart';
import 'package:petrol_pump/Pump/common/models/sidebar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../common/screens/app_drawer.dart';
import '../../common/widgets/sidebar.dart';
import 'add_user.dart';
import 'user_detailed.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit and Debit screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality if needed
            },
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllTransactionsScreen(users: users),
                ),
              );
            },
          ),
        ],
      ),
      drawer: MediaQuery.of(context).size.width < 600
          ? AppDrawer(
              username: 'Petrol Station 1',
              drawerItems: [
                DrawerItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboardScreen');
                    Navigator.pop(context);
                  },
                ),
                DrawerItem(
                  icon: Icons.money,
                  title: 'All Credit and Debit',
                  onTap: () {},
                ),
              ],
            )
          : null,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile) {
          return _buildMobileLayout();
        } else {
          return _buildWebLayout();
        }
      },
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        // Sidebar
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.indigo],
            ),
          ),
          padding: const EdgeInsets.all(16),
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
              const Text(
                'Petrol Station 1',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              SidebarMenuItem(
                  item: SidebarMenuItemModel(
                icon: Icons.dashboard,
                title: 'Dashboard',
                onTap: () {
                  Navigator.pushNamed(context, '/dashboardScreen');
                },
              )),
              SidebarMenuItem(
                item: SidebarMenuItemModel(
                  icon: Icons.money,
                  title: 'All Debits Credits',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
        // Main Content
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          users[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          'Email: ${users[index].email}\nContact: ${users[index].contact}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailsScreen(user: users[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SaveButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddUserScreen(onUserAdded: _addUser)),
                    );
                  },
                  buttonText: "Add User"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          users[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          'Email: ${users[index].email}\nContact: ${users[index].contact}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailsScreen(user: users[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SaveButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddUserScreen(onUserAdded: _addUser)),
                    );
                  },
                  buttonText: "Add User"),
            ],
          ),
        ),
      ],
    );
  }

  void _addUser(User user) {
    setState(() {
      users.add(user);
    });
  }
}
