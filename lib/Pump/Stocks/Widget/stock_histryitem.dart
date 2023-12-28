import 'package:flutter/material.dart';
import 'package:petrol_pump/Pump/Stocks/Models/stock_histry_Item.dart';

class StockHistoryItemWidget extends StatelessWidget {
  final StockHistoryItem historyItem;

  const StockHistoryItemWidget({Key? key, required this.historyItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('${historyItem.type}: ${historyItem.amount}'),
        subtitle: Text('Updated on ${historyItem.timestamp.toString()}'),
      ),
    );
  }
}
