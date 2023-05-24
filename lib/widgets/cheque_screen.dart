import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChequeScreen extends StatefulWidget {
  const ChequeScreen({super.key});

  @override
  State<ChequeScreen> createState() => _ChequeScreenState();
}

class _ChequeScreenState extends State<ChequeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('موعود چک'),
        //backgroundColor: Color(0xff18DAA3),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Text('موعود چک'),
          ),
        ),
      ),
    );
  }
}
