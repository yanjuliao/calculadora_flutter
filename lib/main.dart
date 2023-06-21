// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          toolbarTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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

        if (result.isNaN) {
          //verifica se valor é um número válido
          _displayValue = 'Error';
        } else {
          if (result.toInt() == result) {
            //verifica se o número é inteiro
            _displayValue = result.toInt().toString();
          } else {
            _displayValue =
                result.toStringAsFixed(2); //Se for decimal fixo em duas casas
          }
        }
      } catch (e) {
        _displayValue = 'Error';
      }
    });
  }

  void _calculateSquareRoot() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_displayValue);
        ContextModel cm = ContextModel();
        double value = exp.evaluate(EvaluationType.REAL, cm);

        if (value.isNaN) { //verifica se valor é um número válido
          _displayValue = 'Error';
        } else {
          double result = sqrt(value);
//verifica se o número é inteiro
          if (result.toInt() == result) {
            _displayValue = result.toInt().toString();
          } else {
            _displayValue =
                result.toStringAsFixed(2); //Se for decimal fixo em duas casas
          }
        }
      } catch (e) {
        _displayValue = 'Error';
      }
    });
  }

  void _calculatePercentage() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_displayValue);
        ContextModel cm = ContextModel();
        double value = exp.evaluate(EvaluationType.REAL, cm);

        if (value.isNaN) { //verifica se valor é um número válido
          _displayValue = 'Error';
        } else {
          double result = value / 100;
          _displayValue = result.toString();
        }
      } catch (e) {
        _displayValue = 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.black87,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _displayValue,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: const Color.fromARGB(255, 206, 125, 32),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 3,
              color: const Color.fromARGB(255, 206, 125, 32),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton('C'),
                          _buildButton('%'),
                          _buildButton('/'),
                          _buildButton('⌫'),
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
                          _buildButton('4'),
                          _buildButton('5'),
                          _buildButton('6'),
                          _buildButton('-')
                        ],
                      ),
                    ),
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
                          _buildButton('.'),
                          _buildButton('0'),
                          _buildButton('√'),
                          _buildButton('='),
                        ],
                      ),
                    ),
                  ],
                ),
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
    Color buttonColor = Colors.black,
    Color textColor = const Color.fromARGB(255, 206, 125, 32),
  }) {
    if (text == '=') {
      buttonColor = const Color.fromARGB(255, 206, 125, 32);
      textColor = Colors.black;
      return Expanded(
        child: Container(
          margin: EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              _calculateResult();
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
    } else {
      return Expanded(
        child: Container(
          margin: EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              if (text == 'C') {
                _clearDisplay();
              } else if (text == '⌫') {
                _removeLastCharacter();
              } else if (text == '√') {
                _calculateSquareRoot();
              } else if (text == '%') {
                _calculatePercentage();
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

  void _removeLastCharacter() {
    setState(() {
      if (_displayValue.isNotEmpty) { //Se display não for vazio eu tiro um item da string
        _displayValue = _displayValue.substring(0, _displayValue.length - 1);
      } else { //Se for vazio não faço nada
        return;
      }
    });
  }
}
