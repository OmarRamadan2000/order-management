import '../../../core/constants/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<bool> updateOrderStatus(String orderId, String newStatus);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DioClient dioClient;

  OrderRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await dioClient.get(ApiConstants.ordersEndpoint);

      // Since we're using mock data, let's return hardcoded data for demonstration
      // In a real app, we would parse the API response
      return mockOrders();
    } catch (e) {
      // Fallback to mock data for demo purposes
      return mockOrders();
    }
  }

  @override
  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await dioClient.put(
        '${ApiConstants.ordersEndpoint}/$orderId',
        data: {'status': newStatus},
      );
      return true;
    } catch (e) {
      // In a demo app, we'll just return success
      return true;
    }
  }

  // Mock data for demonstration
  List<OrderModel> mockOrders() {
    return [
      OrderModel(
        id: '1',
        clientName: 'John Smith',
        address: '123 Main St, City',
        status: 'Pending',
        details: {
          'items': [
            {'name': 'Product 1', 'quantity': 2, 'price': 25.99},
            {'name': 'Product 2', 'quantity': 1, 'price': 34.50},
          ],
          'orderDate': '2025-03-28',
          'total': 86.48,
        },
      ),
      OrderModel(
        id: '2',
        clientName: 'Jane Doe',
        address: '456 Oak Ave, Town',
        status: 'Processing',
        details: {
          'items': [
            {'name': 'Product 3', 'quantity': 3, 'price': 15.99},
            {'name': 'Product 4', 'quantity': 2, 'price': 29.99},
          ],
          'orderDate': '2025-03-30',
          'total': 107.95,
        },
      ),
      OrderModel(
        id: '3',
        clientName: 'Alice Johnson',
        address: '789 Pine Rd, Village',
        status: 'Delivered',
        details: {
          'items': [
            {'name': 'Product 5', 'quantity': 1, 'price': 99.99},
          ],
          'orderDate': '2025-03-26',
          'total': 99.99,
        },
      ),
      OrderModel(
        id: '4',
        clientName: 'Alex',
        address: '22 mine Rd, Village',
        status: 'Cancelled',
        details: {
          'items': [
            {'name': 'Product 5', 'quantity': 1, 'price': 33.99},
          ],
          'orderDate': '2025-03-27',
          'total': 33.99,
        },
      ),
    ];
  }
}
