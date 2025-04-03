import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/entities/order.dart';
import '../bloc/orders/orders_cubit.dart';
import '../bloc/orders/orders_state.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrderUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order status updated to ${state.newStatus}'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is OrdersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isUpdating =
              state is OrderUpdating && state.orderId == order.id;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${order.id}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        _buildInfoRow('Client', order.clientName, Icons.person),
                        _buildInfoRow(
                          'Address',
                          order.address,
                          Icons.location_on,
                        ),
                        _buildInfoRow(
                          'Status',
                          order.status,
                          Icons.info_outline,
                        ),
                        _buildInfoRow(
                          'Order Date',
                          order.details['orderDate'] ?? 'N/A',
                          Icons.calendar_today,
                        ),
                        _buildInfoRow(
                          'Total',
                          '\$${order.details['total'] ?? 0}',
                          Icons.attach_money,
                        ),
                      ],
                    ),
                  ),
                ),
                16.verticalSpace,
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              (order.details['items'] as List?)?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item =
                                (order.details['items'] as List)[index];
                            return ListTile(
                              title: Text(item['name']),
                              subtitle: Text('Quantity: ${item['quantity']}'),
                              trailing: Text('\$${item['price']}'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (order.status != 'Delivered' && order.status != 'Cancelled')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text('Mark Delivered'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed:
                              isUpdating
                                  ? null
                                  : () {
                                    context.read<OrdersCubit>().updateStatus(
                                      order.id,
                                      'Delivered',
                                    );
                                  },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel Order'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed:
                              isUpdating
                                  ? null
                                  : () {
                                    context.read<OrdersCubit>().updateStatus(
                                      order.id,
                                      'Cancelled',
                                    );
                                  },
                        ),
                      ),
                    ],
                  ),
                if (isUpdating)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
