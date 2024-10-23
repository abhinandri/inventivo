import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project/db_function/product_function.dart';
import 'package:project/db_function/catagory_function.dart';
import 'package:project/db_function/sales_function.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/model_classes/sales_model.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/color.dart';
import 'package:project/pages/easy_use.dart';
import 'package:project/pages/sales_page/sales_add/add_sale_container.dart';
import 'package:project/pages/sales_page/sales_add/add_sale_list.dart';
import 'package:project/pages/sales_page/sales_add/custom_elevated_button.dart';
import 'package:project/pages/sales_page/sales_add/product_selection.dart';
import 'package:project/pages/sales_page/sales_add/sales_submit_button.dart'; // Import the sales model

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({Key? key}) : super(key: key);

  @override
  _AddSaleScreenState createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _customernameController = TextEditingController();
  final _customernumberController = TextEditingController();

  ProductModel? _selectedProduct;
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  String? selectedCategory;
  String _searchQuery = '';
  List<SelectedProduct> _selectedProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchCategories();
    // _dateController.text = DateTime.now().toString().split(' ')[0];
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _dateController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _customernameController.dispose();
    _customernumberController.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    final fetchedProducts = await getAllProducts();
    if (fetchedProducts != null) {
      setState(() {
        products = fetchedProducts;
      });
    }
  }

  Future<void> _fetchCategories() async {
    final fetchedCategories = await getAllCatogories();
    if (fetchedCategories != null) {
      setState(() {
        categories = fetchedCategories;
      });
    }
  }

  void showProductSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Product',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 16),
              _buildSearchField(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildProductList(),
              ),
            ],
          ),
        );
      },
    ).then((selectedProduct) {
      if (selectedProduct != null) {
        setState(() {
          _selectedProduct = selectedProduct;
          _quantityController.text = '1'; // Default quantity
          _priceController.text =
              selectedProduct.price.toStringAsFixed(2); // Default price
        });
      }
    });
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search Products',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _searchQuery = ''; // Clear the search query
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        // You can implement a debounce function here if needed
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildProductList() {
    List<ProductModel> filteredProducts = products.where((product) {
      return product.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // If no products are found, show a message
    if (filteredProducts.isEmpty) {
      return Center(
        child: Text(
          'No products found',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return addSaleList(filteredProducts: filteredProducts);
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        // _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void addProduct() {
    if (_selectedProduct != null) {
      //check if product is in stock
      if (_selectedProduct!.quantity > 0) {
        setState(() {
          _selectedProducts.add(
            SelectedProduct(
              product: _selectedProduct!,
              quantity: int.parse(_quantityController.text),
              updatedPrice: double.parse(_priceController.text),
            ),
          );
          _selectedProduct = null; // Clear selection
          // _quantityController.clear();
          // _priceController.clear();
        });
      } else {
        _showSnackBar('Product is out of stock');
      }
    }
  }

  void submitSale() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedProducts.isEmpty) {
        _showSnackBar('Please add at least one product');
        return;
      }

      final sale = SalesModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: _dateController.text,
        customerName: _customernameController.text,
        customerNumber: _customernumberController.text,
        products: _selectedProducts
            .map((sp) => ProductModel(
                  name: sp.product.name,
                  imagePath: sp.product.imagePath,
                  id: sp.product.id,
                  categoryId: sp.product.categoryId,
                  brand: sp.product.brand,
                  color: sp.product.color,
                  price: sp.updatedPrice,
                  quantity: sp
                      .quantity, // Ensure to assign the quantity entered by the user
                  description: sp.product.description,
                ))
            .toList(),
        totalAmount: _calculateTotalAmount(),
        saleQuantity: _selectedProducts.fold(0,
            (sum, sp) => sum + sp.quantity), // Total quantity of all products
      );

      await addSale(sale);

      _showSnackBar('Sale added successfully');
      Navigator.pop(context, true);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
    ));
  }

  double _calculateTotalAmount() {
    return _selectedProducts.fold(0.0, (total, product) {
      return total + (product.updatedPrice * product.quantity);
    });
  }

  Widget _buildSelectedProductsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _selectedProducts.length,
          itemBuilder: (context, index) {
            final selectedProduct = _selectedProducts[index];
            final List<String> quantityOptions = [
              '1',
              '2',
              '3',
              '4',
              '5',
              'More'
            ];

            return Dismissible(
              key: ValueKey(selectedProduct.product.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          content: Text(
                              'Are you sure you want to delete this product?'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
              },
              onDismissed: (direction) {
                setState(() {
                  _selectedProducts.removeAt(index);
                });
                _showSnackBar('Product removed');
              },
              background: add_sale_container(),
              child: Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedProduct.product.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price: ₹${selectedProduct.updatedPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                          Row(
                            children: [
                              Text('Qty:', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 8),
                              Container(
                                width: 100,
                                child: DropdownButtonFormField<String>(
                                  value: selectedProduct.quantity <= 5
                                      ? selectedProduct.quantity.toString()
                                      : 'More',
                                  items: quantityOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                  ),
                                  onChanged: (String? newValue) async {
                                    if (newValue == 'More') {
                                      final customQuantity =
                                          await _showCustomQuantityDialog(
                                              context);
                                      if (customQuantity != null &&
                                          customQuantity > 0) {
                                        setState(() {
                                          selectedProduct.quantity =
                                              customQuantity;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        selectedProduct.quantity =
                                            int.parse(newValue!);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${_calculateTotalAmount().toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<int?> _showCustomQuantityDialog(BuildContext context) async {
    TextEditingController _quantityController = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter a quantity',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final int? quantity = int.tryParse(_quantityController.text);
                (quantity != null && quantity > 0)
                    ? Navigator.of(context).pop(quantity)
                    : Navigator.of(context).pop();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomeColors.Primary,
        title: const Text('Add Sale', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextFormField(_dateController, 'Date', Icons.calendar_today,
                  TextInputType.datetime, _selectDate),
              buildTextFormField(
                  _customernameController, 'Customer Name', Icons.person),
              buildTextFormField(_customernumberController, 'Mobile Number',
                  Icons.phone, TextInputType.number),
              SizedBox(
                height: 40,
              ),
              buildProductSelection(),
              // ProductSelection(selectedProduct: _selectedProduct),
              buildTextFormField(_quantityController, 'Quantity',
                  Icons.confirmation_number, TextInputType.number),
              buildTextFormField(_priceController, 'Price', Icons.attach_money,
                  TextInputType.number),
              const SizedBox(height: 16),
              CustomButton(
                addProduct: addProduct,
              ),
              SizedBox(height: 16),
              _buildSelectedProductsList(),
              const SizedBox(height: 24),
              SubmitButton(
                function: submitSale,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductSelection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: showProductSelectionBottomSheet,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Select Product',
            prefixIcon: const Icon(Icons.shopping_cart),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            _selectedProduct?.name ?? 'Product not selected',
            style: TextStyle(
                color: _selectedProduct == null ? Colors.grey : Colors.black),
          ),
        ),
      ),
    );
  }

}

class SelectedProduct {
  ProductModel product;
  int quantity;
  double updatedPrice;

  SelectedProduct({
    required this.product,
    required this.quantity,
    required this.updatedPrice,
  });
}
