import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Stocks/Screens/stock_histry.dart';
import '../../common/models/drawer_item.dart';
import '../../common/models/sidebar.dart';
import '../../common/screens/app_drawer.dart';
import '../../common/widgets/sidebar.dart';
import '../Models/stock_histry_Item.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({Key? key}) : super(key: key);

  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  double petrolStock = 0.0;
  double dieselStock = 0.0;
  List<StockHistoryItem> stockHistory = [];

  TextEditingController petrolController = TextEditingController();
  TextEditingController dieselController = TextEditingController();
  TextEditingController pumpReadingController = TextEditingController();

  String selectedFuelType = 'Petrol';

  void addToStock() {
    double amount = double.parse(
      selectedFuelType == 'Petrol'
          ? petrolController.text
          : dieselController.text,
    );

    setState(() {
      if (selectedFuelType == 'Petrol') {
        petrolStock += amount;
      } else {
        dieselStock += amount;
      }

      stockHistory.add(StockHistoryItem(
        type: '$selectedFuelType Stock',
        amount: amount,
        timestamp: DateTime.now(),
      ));
    });

    // Clear the text fields after updating the stock.
    petrolController.clear();
    dieselController.clear();

    // Show a SnackBar to provide feedback.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$selectedFuelType stock updated successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void deductFromStock() {
    double pumpReading = double.parse(pumpReadingController.text);

    setState(() {
      if (selectedFuelType == 'Petrol') {
        petrolStock -= pumpReading;
      } else {
        dieselStock -= pumpReading;
      }

      stockHistory.add(
        StockHistoryItem(
          type: '$selectedFuelType Pump Reading',
          amount: pumpReading,
          timestamp: DateTime.now(),
        ),
      );
    });

    // Clear the text field after updating the stock.
    pumpReadingController.clear();

    // Show a SnackBar to provide feedback.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '$selectedFuelType Pump Reading deducted from stock successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petrol Diesel Stock'),
      ),
      drawer: MediaQuery.of(context).size.width < 600
          ? AppDrawer(
              username: 'John Doe',
              drawerItems: [
                DrawerItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboardScreen');
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                DrawerItem(
                  icon: Icons.local_gas_station,
                  title: 'Fuel Stock',
                  onTap: () {
                    // Handle navigation to fuel stock screen
                  },
                ),
                // Add more drawer items as needed
              ],
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive UI logic
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return buildMobileLayout(context);
          } else {
            // Web layout
            return buildWebLayout(context);
          }
        },
      ),
    );
  }

  Widget buildWebLayout(BuildContext context) {
    return Row(
      children: [
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
                  icon: Icons
                      .dashboard, // Example icon, replace with the actual icon
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboardScreen');
                  },
                ),
              ),

              SidebarMenuItem(
                  item: SidebarMenuItemModel(
                icon: Icons.local_gas_station,
                title: 'Fuel Stock',
                onTap: () {
                  // Handle navigation to fuel stock screen
                },
              )),
              // Add more menu items as needed
            ],
          ),
        ),
        // Main Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Total Petrol Stock: $petrolStock',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Total Diesel Stock: $dieselStock',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: selectedFuelType == 'Petrol'
                      ? petrolController
                      : dieselController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter Fuel Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: addToStock,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Add Fuel to Stock',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedFuelType,
                      onChanged: (value) {
                        setState(() {
                          selectedFuelType = value!;
                        });
                      },
                      items: ['Petrol', 'Diesel']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockHistoryScreen(
                          stockHistory: stockHistory,
                          historyType: 'Stock',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'View Stock History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: pumpReadingController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter Meter Reading',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: deductFromStock,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Deduct Pump Reading from Stock',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedFuelType,
                      onChanged: (value) {
                        setState(() {
                          selectedFuelType = value!;
                        });
                      },
                      items: ['Petrol', 'Diesel']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockHistoryScreen(
                          stockHistory: stockHistory,
                          historyType: 'Pump Reading',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'View Pump Reading History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total Petrol Stock: $petrolStock',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Diesel Stock: $dieselStock',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: selectedFuelType == 'Petrol'
                ? petrolController
                : dieselController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Enter Fuel Amount'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: addToStock,
                child: const Text('Add Fuel to Stock'),
              ),
              DropdownButton<String>(
                value: selectedFuelType,
                onChanged: (value) {
                  setState(() {
                    selectedFuelType = value!;
                  });
                },
                items: ['Petrol', 'Diesel']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockHistoryScreen(
                    stockHistory: stockHistory,
                    historyType: 'Stock', // or any meaningful string
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'View Stock History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: pumpReadingController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Enter Meter Reading'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: deductFromStock,
                child: const Text('Deduct Pump Reading from Stock'),
              ),
              DropdownButton<String>(
                value: selectedFuelType,
                onChanged: (value) {
                  setState(() {
                    selectedFuelType = value!;
                  });
                },
                items: ['Petrol', 'Diesel']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockHistoryScreen(
                    stockHistory: stockHistory,
                    historyType: 'Pump Reading', // or any meaningful string
                  ),
                ),
              );
            },
            child: const Text('View Pump Reading History'),
          ),
        ],
      ),
    );
  }
}

// class StockHistoryItem extends StatelessWidget {
//   final String type;
//   final double amount;
//   final DateTime? timestamp;

//   const StockHistoryItem({
//     Key? key,
//     required this.type,
//     required this.amount,
//     this.timestamp,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text('$type: $amount'),
//         subtitle: Text('Updated on ${timestamp.toString()}'),
//       ),
//     );
//   }
// }



