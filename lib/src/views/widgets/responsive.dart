import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key? key,
    required this.mobile,
    required this.web,
    required this.tablet,
  }) : super(key: key);
  final Widget mobile;
  final Widget web;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      xs: (context) => mobile,
      sm: (context) => tablet,
      md: (context) => web,
      lg: (context) => web,
      xl: (context) => web,
    );
  }
}
