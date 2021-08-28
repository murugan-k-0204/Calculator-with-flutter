import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
    return MaterialApp(
      title: "Calculator App",
      home: MyHomePage(),
    );
  }
  );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String main_area = "";
  String answer_area = "";
  int last_answer = 0;
  int do_operation(String sign, int a, int b){
    
    if(sign=="+")
      return a+b;
    if(sign=="-")
      return a-b;
    if(sign=="*")
      return a*b;
    if(sign=="/")
      return (a/b).round();
    return 0;

  }

  void calculate(String s){
    s+='+';
    String number = "";
    last_answer = 0;
    String operation = "+";
    int going_to =0;
    for (int i=0; i<s.length;i++){
      if(s[i]!='+' && s[i]!='-' && s[i]!='*'  && s[i]!='/' && s[i]!='%')
        number+=s[i];
      else{
        going_to = int.parse(number);
        number = "";
        last_answer = do_operation(operation, last_answer, going_to);
        operation = s[i];
      }
    }
  }

  SizedBox raiButton(String s, Color color) {
    return SizedBox(
      width: 25.0.w,
      height: 10.0.h,
      child: RaisedButton(
        // disabledColor: color,
        disabledTextColor: Colors.black,
        color: color,
        onPressed: () {
          setState(() {
            if(s=="="){
              calculate(main_area);
            }
            else if(s=='<')
              main_area = main_area.substring(0, main_area.length - 1);
            else if (s == 'C'){
              main_area = "";
              last_answer = 0;
            }
            else
              main_area += s;
          });
        },
        child: Text(s),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator App"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 19.0.h,
            width: 100.0.w,
            child: Center(
              child: Text(
                main_area,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          SizedBox(
            height: 10.0.h,
            width: 100.0.w,

            child: Center(
              child: Text(
                last_answer.toString(),
                style: TextStyle(fontSize: 30),
              ),
              
            ),
          ),
          Row(
            children: [
              raiButton("C", Colors.white),
              raiButton("+", Colors.blueAccent),
              raiButton("-", Colors.blueAccent),
              raiButton("<", Colors.red)
            ],
          ),
          Row(
            children: [
              raiButton("7", Colors.amber),
              raiButton("8", Colors.amber),
              raiButton("9", Colors.amber),
              raiButton("/", Colors.blueAccent)
            ],
          ),
          Row(
            children: [
              raiButton("4", Colors.amber),
              raiButton("5", Colors.amber),
              raiButton("6", Colors.amber),
              raiButton("*", Colors.blueAccent)
            ],
          ),
          Row(
            children: [
              raiButton("1", Colors.amber),
              raiButton("2", Colors.amber),
              raiButton("3", Colors.amber),
              raiButton("%", Colors.blueAccent)
            ],
          ),
          Row(
            children: [
              raiButton("0", Colors.amber),
              raiButton("00", Colors.amber),
              raiButton(".", Colors.amber),
              raiButton("=", Colors.deepOrange)
            ],
          ),
        ],
      ),
    );
  }
}