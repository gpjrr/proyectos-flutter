import 'package:flutter/material.dart';
import 'buttons.dart';

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

// Array of button
  final List<String> Monedas = [
    'Peso',
    'Dolar',
    'Libra',
    'Yein',
  ];
  final List<String> buttons = [
    '7', '8', '9',
    '4', '5', '6',
    '1', '2', '3',
    '0', '.', 'DEl',
  ];
  String opc1='Peso';
  String opc2='Peso';
  List<double> Convert=[
    1,      0.049,  0.038,  6.35,
    20.25,  1,      0.78,   128.47,
    25.95,  1.28,   1,      164.68,
    0.16,   0.0078, 0.0061, 1
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
            "Convertidor",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
            ),
        ),
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
          Row(
            children: [
              Expanded(

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      value: opc1,
                      style: TextStyle(color: Colors.black,fontSize: 30),
                      onChanged: (String niu){
                        setState(() {
                          opc1=niu;
                        });
                      },
                      items: Monedas.map((String location) {
                        return new DropdownMenuItem<String>(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList()
                  ),
                ),
              ),
              Expanded(

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.orange[700], borderRadius: BorderRadius.circular(10)),
                  child: MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput=userInput.substring(0, userInput.length - 1);
                      });
                    },
                    buttonText: 'DEL',
                    color: Colors.orange[700],
                    textColor: Colors.white,
                  ),
                ),
              ),
              Expanded(

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      value: opc2,
                      style: TextStyle(color: Colors.black,fontSize: 30),
                      onChanged: (String niu){
                        setState(() {
                          opc2=niu;
                        });
                      },
                      items: Monedas.map((String location) {
                        return new DropdownMenuItem<String>(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList()
                  ),
                ),
              ),


            ],

          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 11) {
                        return MyButton(
                          buttontapped: () {
                            setState( () {
                              equalPressed();
                            });
                          },
                          buttonText: '=',
                          color:  Colors.blue,
                          textColor: Colors.white,
                        );
                    }
                    // other buttons
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color:  Colors.white,
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
    int o1=0;
    int o2=0;
    for(int i=0;i<4;i++) {
      if (Monedas[i].compareTo(opc1) == 0)
        o1 = i;
      if (Monedas[i].compareTo(opc2) == 0)
        o2 = i;
    }
    double eval=double.parse(userInput);
    eval*=Convert[ o1*4+o2 ];
    answer = eval.toString();
  }
}
