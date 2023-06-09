import 'package:flutter/material.dart';
import 'secondpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('First Page'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('this is first page'),
          Container(
            color: const Color.fromARGB(255, 166, 0, 255),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('go back to home')),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const SecondPage()),
                    ));
              },
              child: const Text('go to second page'))
        ],
      )),
    );
  }
}
