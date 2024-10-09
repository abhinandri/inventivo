import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/model_classes/productModel.dart';
import 'package:project/model_classes/sales_model.dart';
import 'package:project/model_classes/usermodel.dart';

import 'package:project/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Hive.initFlutter();

  // Registering all adapters

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  Hive.registerAdapter(CategoryModelAdapter());

  Hive.registerAdapter(ProductModelAdapter());

  Hive.registerAdapter(BrandModelAdapter());

  Hive.registerAdapter(SalesModelAdapter());

 // Opening all necessary boxes

  await Hive.openBox<UserModel>('user_db');
  await Hive.openBox<CategoryModel>('category_db');
  await Hive.openBox<BrandModel>('brand_db');
  await Hive.openBox<ProductModel>('product_db');
  await Hive.openBox<SalesModel>('salesBox');
  
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
