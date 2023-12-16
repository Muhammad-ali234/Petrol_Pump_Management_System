import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddPetrolSaleScreen extends StatefulWidget {
  const AddPetrolSaleScreen({Key? key}) : super(key: key);

  @override
  _AddPetrolSaleScreenState createState() => _AddPetrolSaleScreenState();
}

class _AddPetrolSaleScreenState extends State<AddPetrolSaleScreen> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Petrol Sale'),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isMobile) {
            return _buildMobileLayout();
          } else {
            return _buildWebLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Product', productController),
          const SizedBox(height: 16.0),
          _buildTextField('Quantity (liters)', quantityController),
          const SizedBox(height: 16.0),
          _buildTextField('Unit Price (\$)', unitPriceController),
          const SizedBox(height: 16.0),
          _buildTextField('Cost Price (\$)', costPriceController),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              _savePetrolSale();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Product', productController),
              const SizedBox(height: 20),
              _buildTextField('Quantity (liters)', quantityController),
              const SizedBox(height: 20),
              _buildTextField('Unit Price (\$)', unitPriceController),
              const SizedBox(height: 20),
              _buildTextField('Cost Price (\$)', costPriceController),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        _savePetrolSale();
      },
      child: const Text('Save'),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  void _savePetrolSale() {
    final String product = productController.text.trim();
    final int quantity = int.tryParse(quantityController.text) ?? 0;
    final double unitPrice = double.tryParse(unitPriceController.text) ?? 0.0;
    final double costPrice = double.tryParse(costPriceController.text) ?? 0.0;

    if (product.isNotEmpty && quantity > 0 && unitPrice > 0 && costPrice > 0) {
      final PetrolSale newSale = PetrolSale(
        product: product,
        quantity: quantity,
        unitPrice: unitPrice,
        date: DateTime.now().toString(),
        costPrice: costPrice,
      );

      Navigator.pop(context, newSale);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter valid values for all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class PetrolSale {
  final String product;
  final int quantity;
  final double unitPrice;
  final String date;
  final double costPrice;

  PetrolSale({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.date,
    required this.costPrice,
  });
}
