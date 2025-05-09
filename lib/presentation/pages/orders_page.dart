import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management/core/widgets/app_navigation.dart';
import 'package:order_management/domain/entities/order.dart';
import '../bloc/auth/auth_cubit.dart';
import '../bloc/orders/orders_cubit.dart';
import '../bloc/orders/orders_state.dart';
import '../widgets/order_list_item.dart';
import 'create_order_page.dart';
import 'login_page.dart';
import 'order_details_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> orders = [];
  List<Order> filteredOrders = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().loadOrders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOrders(String query) {
    setState(() {
      filteredOrders = orders.where((order) {
        final matchesSearch =
            order.clientName.toLowerCase().contains(query.toLowerCase()) ||
                order.address.toLowerCase().contains(query.toLowerCase()) ||
                order.id.toLowerCase().contains(query.toLowerCase());
        final matchesStatus =
            _selectedStatus == 'All' || order.status == _selectedStatus;
        return matchesSearch && matchesStatus;
      }).toList();
    });
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search orders...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterOrders('');
                            },
                          )
                        : null,
                  ),
                  onChanged: _filterOrders,
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedStatus == 'All',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'All';
                            _filterOrders(_searchController.text);
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Processing'),
                        selected: _selectedStatus == 'Processing',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'Processing';
                            _filterOrders(_searchController.text);
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Delivered'),
                        selected: _selectedStatus == 'Delivered',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'Delivered';
                            _filterOrders(_searchController.text);
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Cancelled'),
                        selected: _selectedStatus == 'Cancelled',
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = 'Cancelled';
                            _filterOrders(_searchController.text);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<OrdersCubit, OrdersState>(
              listener: (context, state) {
                if (state is OrdersError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is OrdersLoaded) {
                  setState(() {
                    orders = state.orders;
                    _filterOrders(_searchController.text);
                  });
                }
              },
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return filteredOrders.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
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
                    : const Center(
                        child: Text(
                          "No orders found",
                          style: TextStyle(fontSize: 16),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigation.navigationPush(
            context,
            screen: const CreateOrderPage(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
