import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  static const String routeName="/home";
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(child: Text("hello"),),
    );
  }
}
