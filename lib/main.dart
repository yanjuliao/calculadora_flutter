// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api, use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFFF1D0),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
        hintColor: Color.fromARGB(255, 161, 138, 85),
        scaffoldBackgroundColor: Color(0xFFFFF1D0),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayValue = '';

  void _addToDisplay(String value) {
    setState(() {
      _displayValue += value;
    });
  }

  void _clearDisplay() {
    setState(() {
      _displayValue = '';
    });
  }

  void _calculateResult() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_displayValue);
        ContextModel cm = ContextModel();
        double result = exp.evaluate(EvaluationType.REAL, cm);
        _displayValue = result.toString();
      } catch (e) {
        _displayValue = 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 161, 138, 85),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Color(0xFFFFF1D0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _displayValue,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Color.fromARGB(255, 161, 138, 85),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Color.fromARGB(255, 219, 190, 122),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton('1'),
                          _buildButton('2'),
                          _buildButton('3'),
                          _buildButton('+'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton('4'),
                          _buildButton('5'),
                          _buildButton('6'),
                          _buildButton('-'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton('7'),
                          _buildButton('8'),
                          _buildButton('9'),
                          _buildButton('*'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton('.'),
                          _buildButton('0'),
                          _buildButton('/'), // Botão Limpar
                          _buildButton('C'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    '=',
                    fontSize: 32.0,
                    buttonColor: Color.fromARGB(255, 161, 138, 85),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    String text, {
    double fontSize = 24.0,
    Color buttonColor = const Color.fromARGB(255, 161, 138, 85),
    Color textColor = Colors.white,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            if (text == 'C') {
              _clearDisplay();
            } else if (text == '=') {
              _calculateResult();
            } else {
              _addToDisplay(text);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: textColor,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            minimumSize: Size(80.0, 80.0),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
