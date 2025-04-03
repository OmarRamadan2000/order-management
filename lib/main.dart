import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'di_container.dart' as di;
import 'presentation/bloc/auth/auth_cubit.dart';
import 'presentation/bloc/orders/orders_cubit.dart';
import 'presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleText: () => false,
      builder:
          (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                create: (_) => di.sl<AuthCubit>()..checkLoginStatus(),
              ),
              BlocProvider<OrdersCubit>(create: (_) => di.sl<OrdersCubit>()),
            ],
            child: MaterialApp(
              title: 'Order Management',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.purple,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LoginPage(),
            ),
          ),
    );
  }
}
