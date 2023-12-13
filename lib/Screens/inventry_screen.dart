import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Product> inventoryProducts = [
    Product(name: 'Petrol', quantity: 1000, price: 2.50),
    Product(name: 'Diesel', quantity: 800, price: 2.00),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
      ),
      body: ListView.builder(
        itemCount: inventoryProducts.length,
        itemBuilder: (context, index) {
          return InventoryCard(
            product: inventoryProducts[index],
            onUpdate: () {
              _navigateToUpdateScreen(index);
            },
            onDelete: () {
              _deleteProduct(index);
            },
            onStockIn: () {
              _showStockInDialog(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          ).then((newProduct) {
            if (newProduct != null) {
              _addProduct(newProduct);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToUpdateScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UpdateProductScreen(product: inventoryProducts[index]),
      ),
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      inventoryProducts.removeAt(index);
    });
  }

  void _addProduct(Product newProduct) {
    setState(() {
      inventoryProducts.add(newProduct);
    });
  }

  void _showStockInDialog(int index) {
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stock In'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Product: ${inventoryProducts[index].name}'),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                int quantity = int.tryParse(quantityController.text) ?? 0;
                _stockInProduct(index, quantity);
                Navigator.of(context).pop();
              },
              child: const Text('Stock In'),
            ),
          ],
        );
      },
    );
  }

  void _stockInProduct(int index, int quantity) {
    setState(() {
      inventoryProducts[index].quantity += quantity;
    });
  }
}

class InventoryCard extends StatelessWidget {
  final Product product;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onStockIn;

  const InventoryCard({
    Key? key,
    required this.product,
    required this.onUpdate,
    required this.onDelete,
    required this.onStockIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.orange[400],
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Quantity: ${product.quantity} liters',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: \$${product.price} per liter',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: onUpdate,
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400]),
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: onStockIn,
                  child: const Text(
                    'Stock In',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateProductScreen extends StatelessWidget {
  final Product product;

  const UpdateProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Update Product: ${product.name}',
              style: const TextStyle(fontSize: 20.0),
            ),
            // Add form fields and update logic as needed
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  int quantity;
  final double price;

  Product({required this.name, required this.quantity, required this.price});
}

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price per Liter'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                int quantity = int.tryParse(quantityController.text) ?? 0;
                double price = double.tryParse(priceController.text) ?? 0.0;

                if (name.isNotEmpty && quantity > 0 && price > 0) {
                  Navigator.of(context).pop(
                      Product(name: name, quantity: quantity, price: price));
                } else {
                  // Show an error message or handle invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Invalid input. Please fill all fields.')),
                  );
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
