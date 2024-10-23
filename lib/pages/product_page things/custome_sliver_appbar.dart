import 'package:flutter/material.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/model_classes/usermodel.dart';
import 'package:project/pages/color.dart';
import 'package:project/pages/product_page%20things/invent_sliver_appbar.dart';

class CustomeSliverAppBar extends StatelessWidget {
  const CustomeSliverAppBar({
    super.key,
    required List<CategoryModel> categories,
    required List<BrandModel> brands,
  }) : _categories = categories, _brands = brands;

  final List<CategoryModel> _categories;
  final List<BrandModel> _brands;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CustomeColors.Primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
          bottomLeft: Radius.circular(60),
        ),
      ),
      expandedHeight: 520,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            'Inventivo',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 16),
        background: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: invent_sliver(categories: _categories, brands: _brands),
          ),
        ),
      ),
    );
  }
}