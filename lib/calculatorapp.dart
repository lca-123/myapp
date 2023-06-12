import 'package:flutter/material.dart';

enum Operation { addition, subtraction, multiplication, division }

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _num1Controller = TextEditingController();
  TextEditingController _num2Controller = TextEditingController();
  Operation _selectedOperation = Operation.addition;
  double _result = 0;

  String _operationText() {
    switch (_selectedOperation) {
      case Operation.addition:
        return '加法';
      case Operation.subtraction:
        return '减法';
      case Operation.multiplication:
        return '乘法';
      case Operation.division:
        return '除法';
      default:
        return '';
    }
  }

  void _performOperation() {
    double? num1 = double.tryParse(_num1Controller.text);
    double? num2 = double.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null) {
      _showErrorDialog('请输入有效的数字。');
      return;
    }

    double result;

    switch (_selectedOperation) {
      case Operation.addition:
        result = num1 + num2;
        break;
      case Operation.subtraction:
        result = num1 - num2;
        break;
      case Operation.multiplication:
        result = num1 * num2;
        break;
      case Operation.division:
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          _showErrorDialog('除数不能为零。');
          return;
        }
        break;
    }

    setState(() {
      _result = result;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('错误'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _result = 0;
      _selectedOperation = Operation.addition;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color additionButtonColor =
        _selectedOperation == Operation.addition ? Colors.white : Colors.grey;
    Color subtractionButtonColor = _selectedOperation == Operation.subtraction
        ? Colors.white
        : Colors.grey;
    Color multiplicationButtonColor =
        _selectedOperation == Operation.multiplication
            ? Colors.white
            : Colors.grey;
    Color divisionButtonColor =
        _selectedOperation == Operation.division ? Colors.white : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text('计算器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOperation = Operation.addition;
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: additionButtonColor),
                  child: Text('加法'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOperation = Operation.subtraction;
                    });
                  },
                  style:
                      ElevatedButton.styleFrom(primary: subtractionButtonColor),
                  child: Text('减法'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOperation = Operation.multiplication;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: multiplicationButtonColor),
                  child: Text('乘法'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOperation = Operation.division;
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: divisionButtonColor),
                  child: Text('除法'),
                ),
              ],
            ),
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(labelText: '数字1'),
            ),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(labelText: '数字2'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _performOperation,
              child: Text('计算'),
            ),
            SizedBox(height: 16.0),
            Text(
              '${_operationText()} 的结果: ${_result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _clearFields,
              child: Text('清除'),
            ),
          ],
        ),
      ),
    );
  }
}
