import 'package:flutter/material.dart';

abstract class AppNavigation {
  static Future<T?> navigationPush<T>(
    BuildContext context, {
    required Widget screen,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void navigationPushReplacement(
    BuildContext context, {
    required Widget screen,
  }) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void navigationPop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  static void navigationPushAndRemoveUntil(
    BuildContext context, {
    required Widget screen,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
  }
}

void animatedNavigate(BuildContext context, {required Widget screen}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    ),
  );
}
