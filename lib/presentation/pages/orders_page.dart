import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management/core/widgets/app_navigation.dart';
import 'package:order_management/domain/entities/order.dart';
import '../bloc/auth/auth_cubit.dart';
import '../bloc/orders/orders_cubit.dart';
import '../bloc/orders/orders_state.dart';
import '../widgets/order_list_item.dart';
import 'login_page.dart';
import 'order_details_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().logout();
              AppNavigation.navigationPushReplacement(
                context,
                screen: LoginPage(),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is OrdersLoaded) {
            orders = state.orders;
          }
        },
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return orders.isNotEmpty
              ? ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderListItem(
                    order: order,
                    onTap: () {
                      AppNavigation.navigationPush(
                        context,
                        screen: OrderDetailsPage(order: order),
                      );
                    },
                  );
                },
              )
              : Text("No data founded");
        },
      ),
    );
  }
}
