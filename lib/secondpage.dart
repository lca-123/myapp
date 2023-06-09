import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Second Page'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('this is second page'),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('go back to first page'))
        ],
      )),
    );
  }
}
