import 'package:intl/intl.dart';
import 'package:project/db_function/sales_function.dart';

Future<Map<String, dynamic>> getRevenueData() async {
  final sales = await getAllSales();

  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  double totalRevenue = 0.0;
  double todaysRevenue = 0.0;
  int totalSales = 0;

  for (var sale in sales) {
    totalRevenue +=
        sale.totalAmount ?? 0.0; // Accumulate total revenue for all sales
    totalSales++;
    if (sale.date == today) {
      todaysRevenue += sale.totalAmount ?? 0.0; // Accumulate today's revenue
    }
  }

print('Total Revenue: $totalRevenue, Today\'s Revenue: $todaysRevenue, Total Sales: $totalSales');

  return {
    'todaysRevenue': todaysRevenue,
    'totalRevenue': totalRevenue,
      'totalSales':totalSales,
  };
}
