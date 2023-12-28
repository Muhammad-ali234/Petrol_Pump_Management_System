import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Stocks/Models/stock_histry_Item.dart';

class StockHistoryScreen extends StatelessWidget {
  final List<StockHistoryItem> stockHistory;
  final String historyType;

  const StockHistoryScreen({
    Key? key,
    required this.stockHistory,
    required this.historyType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<StockHistoryItem> filteredHistory =
        stockHistory.where((item) => item.type.contains(historyType)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$historyType History'),
      ),
      body: ListView.builder(
        itemCount: filteredHistory.length,
        itemBuilder: (context, index) {
          // Wrap each StockHistoryItem in a Card for display
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                  '${filteredHistory[index].type}: ${filteredHistory[index].amount}'),
              subtitle: Text(
                  'Updated on ${filteredHistory[index].timestamp.toString()}'),
            ),
          );
        },
      ),
    );
  }
}
