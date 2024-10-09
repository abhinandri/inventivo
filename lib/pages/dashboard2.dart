// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package
// import 'package:project/db_function/revenue_function.dart';
// import 'package:project/pages/Revenue_page/revenue_page.dart';
// import 'package:project/pages/dashboard_Things/stock_availability.dart';

// class Dashboard2 extends StatefulWidget {
//   @override
//   State<Dashboard2> createState() => _Dashboard2State();
// }

// class _Dashboard2State extends State<Dashboard2> {
//   final List<String> productNames = [
//     'hp i3',
//     'Dell',
//     'Lenovo',
//     'Asus',
//     'Apple'
//   ];
//   final List<int> productQuantities = [30, 20, 15, 25, 10];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Inventivo'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Today's Revenue Card
//               _buildRevenueCard(),
//               SizedBox(height: 16),
//               // Check Stock Availability
//               _buildCheckStockAvailabilityCard(),
//               SizedBox(height: 16),
//               // Pie Chart for Top Selling Products
//               buildTopSellingProductsChart(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRevenueCard() {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => RevenuePage()));
//       },
//       child: Card(
//         color: Colors.teal[50],
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: FutureBuilder<Map<String, dynamic>>(
//             future: getRevenueData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 final revenueData = snapshot.data ?? {};
//                 final todaysRevenue = revenueData['todaysRevenue'] ?? 0.0;
//                 final totalRevenue = revenueData['totalRevenue'] ?? 0.0;

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Today\'s Revenue',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.teal[900]),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '₹${todaysRevenue.toStringAsFixed(2)}',
//                       style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.teal),
//                     ),
//                     const SizedBox(height: 12),
//                     const Divider(color: Colors.teal),
//                     const SizedBox(height: 12),
//                     Text(
//                       'Total revenue of the shop',
//                       style: TextStyle(fontSize: 16, color: Colors.teal[800]),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '₹${totalRevenue.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckStockAvailabilityCard() {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => StockAvailabilityPage()),
//         );
//       },
//       child: Card(
//         color: Colors.pink[50],
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Icon(Icons.check_box, size: 50, color: Colors.pink),
//               SizedBox(width: 16),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Check Stock Availability',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.pink[900]),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Ensure stock levels are up to date',
//                     style: TextStyle(fontSize: 16, color: Colors.pink[800]),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTopSellingProductsChart() {
//     return Card(
//       color: Colors.white,
//       elevation: 10,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Top 5 Selling Products',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueGrey[800],
//               ),
//             ),
//             SizedBox(height: 24),
//             Container(
//               height: 200,
//               child: Stack(
//                 children: [
//                   PieChart(
//                     PieChartData(
//                       sections: _createChartSections(),
//                       sectionsSpace: 2,
//                       centerSpaceRadius: 60,
//                       startDegreeOffset: -90,
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Total',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.blueGrey[600],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '${productQuantities.reduce((a, b) => a + b)}',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blueGrey[800],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//             _buildLegend(),
//           ],
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> _createChartSections() {
//     List<PieChartSectionData> sections = [];
//     final colors = [
//       Color(0xFF4FC3F7),
//       Color(0xFFFFD54F),
//       Color(0xFFFF8A65),
//       Color(0xFF81C784),
//       Color(0xFFBA68C8),
//     ];

//     for (int i = 0; i < productNames.length; i++) {
//       sections.add(
//         PieChartSectionData(
//           color: colors[i % colors.length],
//           value: productQuantities[i].toDouble(),
//           title: '',
//           radius: 55,
//           showTitle: false,
//         ),
//       );
//     }
//     return sections;
//   }

//   Widget _buildLegend() {
//     return Wrap(
//       spacing: 16,
//       runSpacing: 8,
//       children: List.generate(
//         productNames.length,
//         (index) => Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: [
//                   Color(0xFF4FC3F7),
//                   Color(0xFFFFD54F),
//                   Color(0xFFFF8A65),
//                   Color(0xFF81C784),
//                   Color(0xFFBA68C8),
//                 ][index % 5],
//               ),
//             ),
//             SizedBox(width: 4),
//             Text(
//               productNames[index],
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.blueGrey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project/db_function/revenue_function.dart';
import 'package:project/db_function/sales_function.dart';
import 'package:project/pages/Revenue_page/revenue_page.dart';
import 'package:project/pages/dashboard_Things/stock_availability.dart';

class Dashboard2 extends StatefulWidget {
  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  List<String> productNames = [];
  List<int> productQuantities = [];

  @override
  void initState() {
    super.initState();
    _fetchTopSellingProducts();
  }

  Future<void> _fetchTopSellingProducts() async {
    final topSelling = await getTopSellingProducts();
    setState(() {
      productNames = topSelling.keys.toList();
      productQuantities = topSelling.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Inventivo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRevenueCard(),
              SizedBox(height: 16),
              _buildCheckStockAvailabilityCard(),
              SizedBox(height: 16),
              buildTopSellingProductsChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRevenueCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RevenuePage()),
        );
      },
      child: Card(
        color: Colors.teal[50],
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<Map<String, dynamic>>(
            future: getRevenueData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final revenueData = snapshot.data ?? {};
                final todaysRevenue = revenueData['todaysRevenue'] ?? 0.0;
                final totalRevenue = revenueData['totalRevenue'] ?? 0.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Revenue',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${todaysRevenue.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.teal),
                    const SizedBox(height: 12),
                    Text(
                      'Total revenue of the shop',
                      style: TextStyle(fontSize: 16, color: Colors.teal[800]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${totalRevenue.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCheckStockAvailabilityCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StockAvailabilityPage()),
        );
      },
      child: Card(
        color: Colors.pink[50],
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.check_box, size: 50, color: Colors.pink),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check Stock Availability',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.pink[900]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ensure stock levels are up to date',
                    style: TextStyle(fontSize: 16, color: Colors.pink[800]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopSellingProductsChart() {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top 5 Selling Products',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 24),
            Container(
              height: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: _createChartSections(),
                      sectionsSpace: 2,
                      centerSpaceRadius: 60,
                      startDegreeOffset: -90,
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          productQuantities.isNotEmpty?
                          "${productQuantities.reduce((a, b) => a + b)}":"0",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _createChartSections() {
    List<PieChartSectionData> sections = [];
    final colors = [
      Color(0xFF4FC3F7),
      Color(0xFFFFD54F),
      Color(0xFFFF8A65),
      Color(0xFF81C784),
      Color(0xFFBA68C8),
    ];

    for (int i = 0; i < productNames.length; i++) {
      sections.add(
        PieChartSectionData(
          color: colors[i % colors.length],
          value: productQuantities[i].toDouble(),
          title: '',
          radius: 55,
          showTitle: false,
        ),
      );
    }
    return sections;
  }
Widget _buildLegend() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
      productNames.length,
      (index) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: [
                Color(0xFF4FC3F7),
                Color(0xFFFFD54F),
                Color(0xFFFF8A65),
                Color(0xFF81C784),
                Color(0xFFBA68C8),
              ][index % 5],
            ),
          ),
          SizedBox(width: 4),
          // Displaying product name and quantity
          Text(
            '${productNames[index]}: ${productQuantities[index]}', // Correctly combining product name and quantity
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey[600],
            ),
          ),
        ],
      ),
    ),
  );
}

}