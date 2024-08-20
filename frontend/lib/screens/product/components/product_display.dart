import 'package:frontend/app_properties.dart';
import 'package:frontend/models/article.dart';
import 'package:flutter/material.dart';

class ProductDisplay extends StatelessWidget {
  final Article product;

  const ProductDisplay({
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: screenAwareSize(200, context),
            child: Hero(
              tag: product.image,
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 0.0,
          child: RawMaterialButton(
            onPressed: () => {},
            constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
            child: Icon(Icons.bookmark, color: Colors.black),
            elevation: 0.0,
            shape: CircleBorder(),
            fillColor: Color.fromRGBO(255, 255, 255, 0.4),
          ),
        )
      ],
    );
  }
}
