import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  bool bandera;
// Array of button
  final List<String> buttons = [
    '7', '8', '9',
    '4', '5', '6',
    '1', '2', '3',
    '0', 'del', '=',
  ];
  final int limit=3999;
  final List<String> Letras =[
    'I', 'V',
    'X', 'L',//50
    'C','D',//500
    'M','W'//1000
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Convertidor Numeros Romanos"),
      ), //AppBar
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                     if (index == 10) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    }
                    // Equal_to Button
                    else if (index == 11) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue,
                        textColor: Colors.white,
                      );
                    }
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            if(  bandera==true) {
                              userInput = "";
                              bandera=false;
                            }
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }


// function to calculate the input operation
  void equalPressed() {
    int val=int.parse( userInput );
    String res="";
    print("usuario=$userInput");
    if( val>limit )
      res="Numeros menores a $limit";
    else {
      int div = 1000;
      int pos=3;
      while (val >= 1) {
        int rdv = val ~/ div;
        if (rdv==4)
          res+="${Letras[pos*2 + 0]}${Letras[pos*2 + 1]}";
        else if( rdv<4 ) {
          for (int i = 0; i < rdv; i++)
            res += "${Letras[pos * 2 + 0]}";
        }
        else if( rdv==9 ){
          res+="${Letras[pos*2 + 0]}${Letras[pos*2 + 2]}";
        }
        else{
          res += "${Letras[pos * 2 + 1]}";
          for (int i = 0; i < rdv-5; i++)
            res += "${Letras[pos * 2 + 0]}";
        }
          pos--;
          val= val%div;
          div = div ~/ 10;
      }
    }
    bandera=true;
    answer =res;
  }
}
