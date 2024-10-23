
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/model_classes/brandmodel.dart';
import 'package:project/pages/inventory_page/brand_item_list.dart';

class brand_gride extends StatelessWidget {
  const brand_gride({
    super.key,
    required List<BrandModel> brands,
  }) : _brands = brands;

  final List<BrandModel> _brands;

  @override
  Widget build(BuildContext context) {
    if (_brands.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.branding_watermark_outlined,
              size: 70,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No brands yet',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
        
          ],
        ),
      );
    }

    return Container(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _brands.length,
        itemBuilder: (context, index) {
          final brand = _brands[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrandProductListPage(
                      brandName: brand.name,
                    ),
                  ),
                );
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E3C72),
                      Color(0xFF2A5298),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      if (brand.imagePath != null &&
                          File(brand.imagePath!).existsSync())
                        Positioned.fill(
                          child: Image.file(
                            File(brand.imagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Text(
                          brand.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (brand.imagePath == null ||
                          !File(brand.imagePath!).existsSync())
                        Center(
                          child: Icon(
                            Icons.branding_watermark,
                            size: 40,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

