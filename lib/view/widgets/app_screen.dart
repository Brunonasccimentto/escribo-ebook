import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  final List<Widget> widgets;
  final Color? backgroundColor;
  final MainAxisAlignment? aligment;
  final AppBar? appBar;

  const AppScreen({super.key, required this.widgets, this.backgroundColor, this.aligment, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Stack(                 
            children: widgets,
          ),
        ),
      ),
    );
  }
}