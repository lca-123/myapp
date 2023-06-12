import 'package:flutter/material.dart';

enum Operation {
  Addition,
  Subtraction,
  Multiplication,
  Division,
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _num1Controller = TextEditingController();
  TextEditingController _num2Controller = TextEditingController();
  late double? _result;
  late Operation? _selectedOperation;
  @override
  void initState() {
    super.initState();
    _selectedOperation = Operation.Addition;
    _result = 0; // 或者您可以选择任何默认操作
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  void _performOperation() {
    double num1 = double.tryParse(_num1Controller.text) ?? 0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0;

    if (_selectedOperation == Operation.Addition) {
      _result = num1 + num2;
    } else if (_selectedOperation == Operation.Subtraction) {
      _result = num1 - num2;
    } else if (_selectedOperation == Operation.Multiplication) {
      _result = num1 * num2;
    } else if (_selectedOperation == Operation.Division) {
      if (num2 != 0) {
        _result = num1 / num2;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Cannot divide by zero.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    setState(() {});
  }

  void _clearFields() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _result = null;
      _selectedOperation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<Operation>(
              value: _selectedOperation,
              items: [
                DropdownMenuItem<Operation>(
                  value: Operation.Addition,
                  child: Text('Addition'),
                ),
                DropdownMenuItem<Operation>(
                  value: Operation.Subtraction,
                  child: Text('Subtraction'),
                ),
                DropdownMenuItem<Operation>(
                  value: Operation.Multiplication,
                  child: Text('Multiplication'),
                ),
                DropdownMenuItem<Operation>(
                  value: Operation.Division,
                  child: Text('Division'),
                ),
              ],
              onChanged: (Operation? value) {
                setState(() {
                  _selectedOperation = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Operation',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Number 1',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Number 2',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _performOperation,
              child: Text('Calculate'),
            ),
            SizedBox(height: 16.0),
            Text(
              // ignore: unnecessary_null_comparison
              _result != null ? 'Result: $_result' : '',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _clearFields,
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}
