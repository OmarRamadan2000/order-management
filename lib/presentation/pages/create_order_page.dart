import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_management/core/widgets/app_navigation.dart';
import 'package:order_management/core/widgets/text_field_widget.dart';
import 'package:order_management/data/models/order_model.dart';
import '../bloc/orders/orders_cubit.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final List<Map<String, dynamic>> _items = [];
  final _itemNameController = TextEditingController();
  final _itemQuantityController = TextEditingController();
  final _itemPriceController = TextEditingController();

  @override
  void dispose() {
    _clientNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _itemNameController.dispose();
    _itemQuantityController.dispose();
    _itemPriceController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_itemNameController.text.isNotEmpty &&
        _itemQuantityController.text.isNotEmpty &&
        _itemPriceController.text.isNotEmpty) {
      setState(() {
        _items.add({
          'name': _itemNameController.text,
          'quantity': int.parse(_itemQuantityController.text),
          'price': double.parse(_itemPriceController.text),
        });
        _itemNameController.clear();
        _itemQuantityController.clear();
        _itemPriceController.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _createOrder() {
    if (_formKey.currentState!.validate() && _items.isNotEmpty) {
      final order = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        clientName: _clientNameController.text,
        address: _addressController.text,
        status: 'Processing',
        details: {
          'phone': _phoneController.text,
          'orderDate': DateTime.now().toIso8601String(),
          'items': _items,
          'total': _items.fold<double>(
            0,
            (sum, item) => sum + (item['price'] * item['quantity']),
          ),
        },
      );

      // Create the order using OrdersCubit
      context.read<OrdersCubit>().createOrder(order);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order created successfully!')),
      );
      AppNavigation.navigationPop(context);
    } else if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Order')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      16.verticalSpace,
                      TextFieldWidget(
                        controller: _clientNameController,
                        label: 'Customer Name',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,
                      TextFieldWidget(
                        controller: _addressController,
                        label: 'Delivery Address',
                        prefixIcon: const Icon(Icons.location_on),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter delivery address';
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,
                      TextFieldWidget(
                        controller: _phoneController,
                        label: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
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
                        'Order Items',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      16.verticalSpace,
                      Column(
                        spacing: 10,
                        children: [
                          TextFieldWidget(
                            controller: _itemNameController,
                            label: 'Item Name',
                            prefixIcon: const Icon(Icons.shopping_bag),
                          ),
                          const SizedBox(width: 8),
                          TextFieldWidget(
                            controller: _itemQuantityController,
                            label: 'Quantity',
                            prefixIcon: const Icon(Icons.numbers),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(width: 8),
                          TextFieldWidget(
                            controller: _itemPriceController,
                            label: 'Price',
                            prefixIcon: const Icon(Icons.attach_money),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      ElevatedButton.icon(
                        onPressed: _addItem,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Item'),
                      ),
                      16.verticalSpace,
                      if (_items.isNotEmpty) ...[
                        const Text(
                          'Added Items:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        8.verticalSpace,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            return ListTile(
                              title: Text(item['name']),
                              subtitle: Text(
                                'Quantity: ${item['quantity']} - Price: \$${item['price']}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeItem(index),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              24.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _createOrder,
                  icon: const Icon(Icons.save),
                  label: const Text('Create Order'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
