import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyOrganizationTabScreen extends StatelessWidget {
  const MyOrganizationTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
