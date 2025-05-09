import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import '../../../domain/entities/order.dart';
import '../bloc/orders/orders_cubit.dart';
import '../bloc/orders/orders_state.dart';
import '../widgets/order/order_info_card.dart';
import '../widgets/order/order_items_card.dart';
import '../widgets/order/order_notes_card.dart';
import '../widgets/order/order_actions.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final TextEditingController _notesController = TextEditingController();
  bool _isAddingNote = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _shareOrder() {
    final orderDetails = '''
Order #${widget.order.id}
Client: ${widget.order.clientName}
Address: ${widget.order.address}
Status: ${widget.order.status}
Order Date: ${widget.order.details['orderDate'] ?? 'N/A'}
Total: \$${widget.order.details['total'] ?? 0}

Items:
${(widget.order.details['items'] as List?)?.map((item) => '- ${item['name']} (${item['quantity']}x) - \$${item['price']}').join('\n') ?? 'No items'}
''';
    Share.share(orderDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareOrder),
        ],
      ),
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
              state is OrderUpdating && state.orderId == widget.order.id;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderInfoCard(order: widget.order),
                16.verticalSpace,
                OrderItemsCard(order: widget.order),
                16.verticalSpace,
                const OrderNotesCard(),
                const SizedBox(height: 24),
                OrderActions(
                  order: widget.order,
                  isUpdating: isUpdating,
                ),
                if (isUpdating)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
