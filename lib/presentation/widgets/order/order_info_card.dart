import 'package:flutter/material.dart';
import '../../../domain/entities/order.dart';
import 'order_status_chip.dart';

class OrderInfoCard extends StatelessWidget {
  final Order order;

  const OrderInfoCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order #${order.id}',
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                OrderStatusChip(status: order.status),
              ],
            ),
            const Divider(),
            _buildInfoRow(
              'Client',
              order.clientName,
              Icons.person,
            ),
            _buildInfoRow(
              'Address',
              order.address,
              Icons.location_on,
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
