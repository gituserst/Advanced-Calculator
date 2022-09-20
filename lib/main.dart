import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText){
    setState(() {
      if (buttonText == "C"){
        equation = "0";
        result = "0";
      }
      else if(buttonText == "e"){
        equation = "2,7182818284";
      }
      else if(buttonText == "π"){
        equation = "3.14";
      }

      else if(buttonText == "⌫"){
        equation = equation.substring(0, equation.length - 1);
        if(equation ==""){
          equation = "0";
        }
      }
      else if(buttonText == "="){

        expression = equation;

        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }
      else{
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: 37),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: 37),),
          ),

          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .80,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.redAccent),
                          buildButton("(", 1, Colors.blue),
                          buildButton(")", 1, Colors.blue),
                          buildButton("ln", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                          buildButton("sin", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                          buildButton("cos", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                          buildButton("tan", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("e", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("π", 1, Colors.black54),
                          buildButton("cot", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.blue),
                          buildButton("x²", 1, Colors.blue),
                          buildButton("sqrt", 1, Colors.blue),
                          buildButton("lg", 1, Colors.blue),
                        ]
                    ),//√
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("⌫", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("/", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("*", 1, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 1, Colors.redAccent),
                        ]
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}