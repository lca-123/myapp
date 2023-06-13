import 'package:flutter/material.dart';

class DynamicTextFields extends StatefulWidget {
  @override
  _DynamicTextFieldsState createState() => _DynamicTextFieldsState();
}

class _DynamicTextFieldsState extends State<DynamicTextFields> {
  List<Widget> textFields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Text Fields'),
      ),
      body: ListView.builder(
        itemCount: textFields.length,
        itemBuilder: (context, index) => textFields[index],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            textFields.add(buildTextField());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Enter some text',
        ),
      ),
    );
  }
}
