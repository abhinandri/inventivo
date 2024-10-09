
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project/db_function/sales_function.dart';
import 'package:project/pages/color.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({Key? key}) : super(key: key);

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  DateTimeRange? selectedDateRange;
  Future<Map<String, dynamic>>? revenueDataFuture; // Store the Future here

  @override
  void initState() {
    super.initState();
    revenueDataFuture = getRevenueData(); // Initial fetch
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange,
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
        revenueDataFuture = getRevenueData(from: picked.start, to: picked.end); // Refetch data with new range
      });
    }
  }

  Future<Map<String, dynamic>> getRevenueData({DateTime? from, DateTime? to}) async {
    final sales = await getAllSales();

    final startDate = from ?? DateTime(2000); // Default start date if none selected
    final endDate = to ?? DateTime.now(); // Default end date if none selected

    double totalRevenue = 0.0;
    double todaysRevenue = 0.0;
    int totalSales = 0;
    List<double> weeklyRevenue = List.filled(7, 0.0); // For weekly revenue tracking

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    for (var sale in sales) {
      final saleDate = DateTime.parse(sale.date); // Ensure sale.date is in correct format

      // Check if the saleDate is within the selected range
      if (saleDate.isAfter(startDate.subtract(Duration(days: 1))) && saleDate.isBefore(endDate.add(Duration(days: 1)))) {
        totalRevenue += sale.totalAmount ?? 0.0;
        totalSales++;

        // Check if the sale was made today
        if (sale.date == today) {
          todaysRevenue += sale.totalAmount ?? 0.0;
        }

        // Get the weekday index (0 for Monday, 6 for Sunday)
        final dayOfWeek = (saleDate.weekday - 1) % 7; 
        weeklyRevenue[dayOfWeek] += sale.totalAmount ?? 0.0; // Aggregate revenue for the week
      }
    }

    return {
      'todaysRevenue': todaysRevenue,
      'totalRevenue': totalRevenue,
      'totalSales': totalSales,
      'weeklyRevenue': weeklyRevenue,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Revenue',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: CustomeColors.Primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _pickDateRange,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: revenueDataFuture, // Use the future variable
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          Map<String, dynamic> revenueData = snapshot.data!;
          double todaysRevenue = revenueData['todaysRevenue'];
          double totalRevenue = revenueData['totalRevenue'];
          int totalSales = revenueData['totalSales'];
          List<double> weeklyRevenue = revenueData['weeklyRevenue'] ?? List.filled(7, 0.0);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedDateRange == null
                        ? 'No date range selected'
                        : 'Selected Range: ${DateFormat('MMM d').format(selectedDateRange!.start)} - ${DateFormat('MMM d').format(selectedDateRange!.end)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryCards(totalRevenue, totalSales, todaysRevenue),
                  const SizedBox(height: 24),
                  _buildRevenueChart(weeklyRevenue),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCards(double totalRevenue, int totalSales, double todaysRevenue) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildCard('Total Revenue', '₹${NumberFormat('#,##0.00').format(totalRevenue)}', Colors.green),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildCard('Total Sales', totalSales.toString(), Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCard(String title, String value, Color valueColor) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(List<double> weeklyRevenue) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Revenue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          return Text(days[value.toInt() % 7]);
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text('₹${value.toInt()}');
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: weeklyRevenue.reduce((a, b) => a > b ? a : b),
                  lineBarsData: [
                    LineChartBarData(
                      spots: weeklyRevenue
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value))
                          .toList(),
                      isCurved: true,
                      color: CustomeColors.Primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: CustomeColors.Primary.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
