// import 'package:flutter/material.dart';

// class ProfitSalesScreen extends StatefulWidget {
//   const ProfitSalesScreen({Key? key}) : super(key: key);

//   @override
//   _ProfitSalesScreenState createState() => _ProfitSalesScreenState();
// }

// class _ProfitSalesScreenState extends State<ProfitSalesScreen> {
//   List<PetrolSale> petrolSales = [
//     PetrolSale(
//       product: 'Petrol 95',
//       quantity: 500,
//       unitPrice: 2.50,
//       date: '2023-01-15',
//       costPrice: 2.00,
//     ),
//     PetrolSale(
//       product: 'Diesel',
//       quantity: 300,
//       unitPrice: 2.00,
//       date: '2023-01-16',
//       costPrice: 1.80,
//     ),
//     // Add more petrol sales as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Petrol Sales and Profit'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Implement filter action
//               // You can show a bottom sheet or navigate to a separate filter screen
//             },
//             icon: const Icon(Icons.filter_list),
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 16.0),
//           _buildPetrolSalesList(),
//           const SizedBox(height: 16.0),
//           _buildTotalSalesAndProfit(),
//           const SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const AddPetrolSaleScreen()),
//               ).then((newSale) {
//                 if (newSale != null) {
//                   _addPetrolSale(newSale);
//                 }
//               });
//             },
//             child: const Text('Add New Petrol Sale'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPetrolSalesList() {
//     return Expanded(
//       child: petrolSales.isEmpty
//           ? const Center(
//               child: Text(
//                 'No petrol sales available.\nAdd a new petrol sale to get started!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: petrolSales.length,
//               itemBuilder: (context, index) {
//                 return PetrolSaleCard(petrolSale: petrolSales[index]);
//               },
//             ),
//     );
//   }

//   Widget _buildTotalSalesAndProfit() {
//     int totalSales =
//         petrolSales.map((sale) => sale.quantity).fold(0, (a, b) => a + b);
//     double totalProfit =
//         petrolSales.map((sale) => sale.profit()).fold(0, (a, b) => a + b);

//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.green[100],
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         children: [
//           const Text(
//             'Total Petrol Sales',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             'Total Sales: $totalSales liters',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18.0,
//               color: Colors.green,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             'Total Profit: \$${totalProfit.toStringAsFixed(2)}',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18.0,
//               color: Colors.green,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _addPetrolSale(PetrolSale newSale) {
//     setState(() {
//       petrolSales.add(newSale);
//     });
//   }
// }

// class PetrolSaleCard extends StatelessWidget {
//   final PetrolSale petrolSale;

//   const PetrolSaleCard({Key? key, required this.petrolSale}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       elevation: 4.0,
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(16.0),
//         title: Text(
//           petrolSale.product,
//           style: const TextStyle(color: Colors.green),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 8.0),
//             Text(
//               'Quantity: ${petrolSale.quantity} liters',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Unit Price: \$${petrolSale.unitPrice.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Total Sale: \$${petrolSale.totalSale().toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Profit: \$${petrolSale.profit().toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Date: ${petrolSale.date}',
//               style: const TextStyle(fontSize: 14.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PetrolSale {
//   final String product;
//   final int quantity;
//   final double unitPrice;
//   final String date;
//   final double costPrice;

//   PetrolSale({
//     required this.product,
//     required this.quantity,
//     required this.unitPrice,
//     required this.date,
//     required this.costPrice,
//   });

//   double totalSale() {
//     return quantity * unitPrice;
//   }

//   double profit() {
//     return (unitPrice - costPrice) * quantity;
//   }
// }

// class AddPetrolSaleScreen extends StatelessWidget {
//   const AddPetrolSaleScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New Petrol Sale'),
//       ),
//       body: const Center(
//         child: Text('This is the Add Petrol Sale Screen'),
//       ),
//     );
//   }
// }
