import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/cart/ui/pages/managers/checkout_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.products});
  final List<ProductEntityModel> products;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: _CheckoutPageBody(products: products),
    );
  }
}

class _CheckoutPageBody extends StatelessWidget {
  const _CheckoutPageBody({required this.products});
  final List<ProductEntityModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name ?? ''),
                  subtitle: Text('\$${product.price}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 20)),
                    Text(
                      '\$${products.fold(0.0, (sum, item) => sum + (item.price ?? 0))}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BlocListener<CheckoutCubit, CheckoutState>(
                  listener: (context, state) {
                    if (state.placeOrder.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order placed successfully'),
                        ),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CheckoutCubit>().placeOrder(products);
                    },
                    child: const Text('Place Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
