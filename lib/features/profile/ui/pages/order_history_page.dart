import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';
import 'package:e_commerce_web_app/features/profile/ui/managers/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.orders.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.orders.isFailure) {
            return Center(child: Text(state.orders.failureMessage ?? ''));
          } else if (state.orders.isSuccess) {
            return ListView.builder(
              itemCount: state.orders.data!.length,
              itemBuilder: (context, index) {
                final order = state.orders.data![index];
                return _OrderCard(order: order);
              },
            );
          } else {
            return Center(child: Text('somthing went wrong'));
          }
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date: ${order.date}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total: ${order.totalPrice}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text('Products:', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8.0),
            ...order.products.map(
              (product) => ListTile(
                title: Text(product.name ?? ''),
                subtitle: Text('${product.price}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
