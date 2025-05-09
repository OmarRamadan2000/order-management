import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/order.dart';
import '../../bloc/orders/orders_cubit.dart';

class OrderActions extends StatelessWidget {
  final Order order;
  final bool isUpdating;

  const OrderActions({
    Key? key,
    required this.order,
    required this.isUpdating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (order.status == 'Delivered' || order.status == 'Cancelled') {
      return const SizedBox.shrink();
    }

    return Row(
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
            onPressed: isUpdating
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
            onPressed: isUpdating
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
    );
  }
}
