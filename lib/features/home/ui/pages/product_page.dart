import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.images});
  final List<String> images;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
            
              Flexible(
                child: Row(
                  children: [
                    Text("Products"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(widget.images[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
