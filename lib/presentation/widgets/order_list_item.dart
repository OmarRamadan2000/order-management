import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_management/presentation/widgets/order/order_status_chip.dart';
import '../../../domain/entities/order.dart';

class OrderListItem extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderListItem({Key? key, required this.order, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.r),
        title: Text(
          order.clientName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            4.verticalSpace,
            Text(order.address),
            8.verticalSpace,
            OrderStatusChip(status: order.status),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          child: const Text('Details'),
        ),
        onTap: onTap,
      ),
    );
  }
}
