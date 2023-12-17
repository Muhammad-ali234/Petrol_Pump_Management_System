import 'package:flutter/material.dart';

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
        type: selectedFuelType,
        amount: amount,
        timestamp: null,
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
        // Sidebar
        Container(
          width: 250,
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboardScreen');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 50),
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
                child: const Text('Dashboard'),
              ),
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      const InputDecoration(labelText: 'Enter Fuel Amount'),
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
                TextField(
                  controller: pumpReadingController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Enter Pump Reading Amount'),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StockHistoryScreen(stockHistory: stockHistory),
                      ),
                    );
                  },
                  child: const Text('View Stock History'),
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
          TextField(
            controller: pumpReadingController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration:
                const InputDecoration(labelText: 'Enter Pump Reading Amount'),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StockHistoryScreen(stockHistory: stockHistory),
                ),
              );
            },
            child: const Text('View Stock History'),
          ),
        ],
      ),
    );
  }
}

class StockHistoryItem extends StatelessWidget {
  final String type;
  final double amount;
  final DateTime? timestamp;

  const StockHistoryItem({
    Key? key,
    required this.type,
    required this.amount,
    this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('$type: $amount'),
        subtitle: Text('Updated on ${timestamp.toString()}'),
      ),
    );
  }
}

class StockHistoryScreen extends StatelessWidget {
  final List<StockHistoryItem> stockHistory;

  const StockHistoryScreen({Key? key, required this.stockHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock History'),
      ),
      body: ListView.builder(
        itemCount: stockHistory.length,
        itemBuilder: (context, index) {
          return stockHistory[index];
        },
      ),
    );
  }
}
