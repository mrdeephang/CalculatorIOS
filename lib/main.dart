import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iPhone Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _current = "";
  String _operator = "";
  double _firstNumber = 0;

  void _buttonPressed(String text) {
    setState(() {
      switch (text) {
        case "C":
          _output = "0";
          _current = "";
          _operator = "";
          _firstNumber = 0;
          break;
        case "+/-":
          if (_current.isNotEmpty) {
            if (_current.startsWith("-")) {
              _current = _current.substring(1);
            } else {
              _current = "-$_current";
            }
            _output = _current;
          }
          break;
        case "%":
          if (_current.isNotEmpty) {
            double value = double.tryParse(_current) ?? 0;
            _current = (value / 100).toString();
            _output = _current;
          }
          break;
        case "+":
        case "-":
        case "×":
        case "÷":
          _firstNumber = double.tryParse(_current) ?? 0;
          _operator = text;
          _current = "";
          break;
        case "=":
          double secondNumber = double.tryParse(_current) ?? 0;
          double result = 0;
          switch (_operator) {
            case "+":
              result = _firstNumber + secondNumber;
              break;
            case "-":
              result = _firstNumber - secondNumber;
              break;
            case "×":
              result = _firstNumber * secondNumber;
              break;
            case "÷":
              result = secondNumber != 0 ? _firstNumber / secondNumber : 0;
              break;
          }
          _output = result.toStringAsFixed(2);
          _current = _output;
          _operator = "";
          break;
        default:
          if (_current == "0" && text != ".") {
            _current = text;
          } else {
            _current += text;
          }
          _output = _current;
      }
    });
  }

  Widget _buildButton(
    String text, {
    Color color = const Color(0xFF333333),
    Color textColor = Colors.white,
    bool isWide = false,
  }) {
    return Expanded(
      flex: isWide ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: isWide ? const StadiumBorder() : const CircleBorder(),
            padding: isWide
                ? const EdgeInsets.symmetric(vertical: 22)
                : const EdgeInsets.all(22),
          ),
          child: Align(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            child: Padding(
              padding: isWide
                  ? const EdgeInsets.only(left: 28.0)
                  : EdgeInsets.zero,
              child: Text(
                text,
                style: TextStyle(fontSize: 28, color: textColor),
              ),
            ),
          ),
          onPressed: () => _buttonPressed(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: Text(
                  _output,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton(
                      "C",
                      color: Colors.grey,
                      textColor: Colors.black,
                    ),
                    _buildButton(
                      "+/-",
                      color: Colors.grey,
                      textColor: Colors.black,
                    ),
                    _buildButton(
                      "%",
                      color: Colors.grey,
                      textColor: Colors.black,
                    ),
                    _buildButton("÷", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("×", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("+", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("0", isWide: true),
                    _buildButton("."),
                    _buildButton("=", color: Colors.orange),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
