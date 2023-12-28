// stock_history_item.dart

class StockHistoryItem {
  final String type;
  final double amount;
  final DateTime? timestamp;

  StockHistoryItem({
    required this.type,
    required this.amount,
    this.timestamp,
  });
}
