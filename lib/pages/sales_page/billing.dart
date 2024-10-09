
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/model_classes/sales_model.dart';
import 'package:project/pages/sales_page/biling_details.dart';
import 'package:project/pages/sales_page/sales_add_page.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<SalesModel> _sales = [];
  List<SalesModel> _allSales = []; // Store all sales for filtering
  DateTime? _startDate;
  DateTime? _endDate;
  
  @override
  void initState() {
    super.initState();
    _fetchSales(); // Fetch sales data when the page is initialized
  }
  Future<void> _fetchSales() async {
    final salesBox = await Hive.openBox<SalesModel>('salesBox');
    setState(() {
      _allSales = salesBox.values.toList(); // Store all sales
      _sales = List.from(_allSales); // Initialize filtered sales
      _sales.sort((a, b) => b.date.compareTo(a.date)); // Sort by date, newest first
    });
    _filterSalesByDateRange(); // Apply filtering immediately based on current dates
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null  
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : DateTimeRange(
              start: DateTime.now(),
              end: DateTime.now(),
            ),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _filterSalesByDateRange(); // Filter sales immediately after date selection
    }
  }
  void _filterSalesByDateRange() {
    if (_startDate == null || _endDate == null) {
      _sales = List.from(_allSales); // Reset to all sales if no date range is set
    } else {
      setState(() {
        _sales = _allSales.where((sale) {
          DateTime saleDate = DateTime.parse(sale.date);
          return saleDate.isAfter(_startDate!.subtract(Duration(days: 1))) && // Include start date
              saleDate.isBefore(_endDate!.add(Duration(days: 1))); // Include end date
        }).toList();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sales',style: TextStyle(color:Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFF17A2B8),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today,color: Colors.white,),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: _sales.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No recent sales',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the button to add a new sale',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: _sales.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final sale = _sales[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF17A2B8),
                    child: Text(
                      sale.customerName[0].toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(sale.customerName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number: ${sale.customerNumber}'),
                      Text('Date: ${sale.date.toString().substring(0, 10)}'),
                    ],
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaleDetailsPage(sale: sale),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSaleScreen()),
          ).then((_) {
            _fetchSales(); // Fetch sales data after returning from AddSaleScreen
          });
        },
        icon: Icon(Icons.add),
        label: Text('Add Sale'),
        backgroundColor: Color(0xFF17A2B8),
      ),
    );
  }
}
