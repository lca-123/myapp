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
  bool _isnumone = true;
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
      _isnumone = true;
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
    Color num1ButtonColor = _isnumone ? Colors.white : Colors.grey;
    Color num2ButtonColor = !_isnumone ? Colors.white : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text('计算器'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    style:
                        ElevatedButton.styleFrom(primary: additionButtonColor),
                    child: Text('加法'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedOperation = Operation.subtraction;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: subtractionButtonColor),
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
                    style:
                        ElevatedButton.styleFrom(primary: divisionButtonColor),
                    child: Text('除法'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isnumone = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: num1ButtonColor),
                    child: Text('数字1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isnumone = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: num2ButtonColor),
                    child: Text('数字2'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              CustomKeyboard(onNumberPressed: (number) {
                setState(() {
                  if (_isnumone) {
                    _num1Controller.text += number;
                  } else {
                    _num2Controller.text += number;
                  }
                });
              }),
              SizedBox(height: 16.0),
              TextField(
                controller: _num1Controller,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(labelText: '数字1'),
              ),
              SizedBox(height: 16.0),
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
      ),
    );
  }
}

class CustomKeyboard extends StatelessWidget {
  final Function(String) onNumberPressed;

  CustomKeyboard({required this.onNumberPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildNumberButton('1'),
            _buildNumberButton('2'),
            _buildNumberButton('3'),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _buildNumberButton('4'),
            _buildNumberButton('5'),
            _buildNumberButton('6'),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _buildNumberButton('7'),
            _buildNumberButton('8'),
            _buildNumberButton('9'),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _buildNumberButton('.'),
            _buildNumberButton('0'),
            _buildNumberButton('e'),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          onNumberPressed(number);
        },
        child: Text(number),
      ),
    );
  }
}
