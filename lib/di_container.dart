import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_client.dart';
import 'core/storage/shared_pref_manager.dart';
import 'data/datasources/local/auth_local_datasource.dart';
import 'data/datasources/local/order_local_datasource.dart';
import 'data/datasources/remote/order_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/usecases/get_orders.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/update_order_status.dart';
import 'presentation/bloc/auth/auth_cubit.dart';
import 'presentation/bloc/orders/orders_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

  // Core
  sl.registerLazySingleton(() => DioClient(sl()));
  sl.registerLazySingleton(() => SharedPrefManager(sl()));

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPrefManager: sl()),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPrefManager: sl()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(dioClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => GetOrders(sl()));
  sl.registerLazySingleton(() => UpdateOrderStatus(sl()));

  // Cubits
  sl.registerFactory(() => AuthCubit(loginUser: sl()));
  sl.registerFactory(
    () => OrdersCubit(getOrders: sl(), updateOrderStatus: sl()),
  );
}
