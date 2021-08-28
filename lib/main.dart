import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class SizeConfig{
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double Height;
  static late double Width;

  static late double _safeAreaHori;
  static late double _safeAreaVert;
  static late double safeAreaHeight;
  static late double safeAreaWidth;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    Width = screenWidth/100;
    Height = screenHeight/100;

    _safeAreaVert = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaHori = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeAreaHeight = (screenHeight - _safeAreaHori) / 100;
    safeAreaWidth = (screenWidth - _safeAreaVert) / 100;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator App",
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
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
  double last_answer = 0;

  double do_operation(String sign, double a, double b){
    if(sign=="+")
      return a+b;
    if(sign=="-")
      return a-b;
    if(sign=="*")
      return a*b;
    if(sign=="/")
      return (a/b);
    return 0.0;
  }

  void calculate(String s){
    s+='+';
    String number = "";
    last_answer = 0;
    String operation = "+";
    double going_to =0;
    for (int i=0; i<s.length;i++){
      if(s[i]!='+' && s[i]!='-' && s[i]!='*'  && s[i]!='/' && s[i]!='%')
        number+=s[i];
      else{
        going_to = double.parse(number);
        number = "";
        last_answer = do_operation(operation, last_answer, going_to);
        operation = s[i];
      }
    }
  }

  SizedBox raiButton(String s, Color color, double w, double h) {
    return SizedBox(
      height: 10 * h,
      width: 25 * w,
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
        child: Text(s,style: TextStyle(fontSize: 30),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double w = SizeConfig.safeAreaWidth;
    double h = SizeConfig.safeAreaHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator App"),
        
      ),
      body: Column(
        children: [
          SizedBox(
            height: 31.5 * h,
            width: 100 * w,
            child: Center(
              
              child: Text(
                main_area,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          SizedBox(
            height: 10*h,
            width: 100*w,
            child: Center(
              child: Text(
                last_answer.toString(),
                style: TextStyle(fontSize: 30),
              ),
              
            ),
          ),
          Row(
            children: [
              raiButton("C", Colors.white,w,h),
              raiButton("+", Colors.blueAccent,w,h),
              raiButton("-", Colors.blueAccent,w,h),
              raiButton("<", Colors.red,w,h),
            ],
          ),
          Row(
            children: [
              raiButton("7", Colors.amber,w,h),
              raiButton("8", Colors.amber,w,h),
              raiButton("9", Colors.amber,w,h),
              raiButton("/", Colors.blueAccent,w,h),
            ],
          ),
          Row(
            children: [
              raiButton("4", Colors.amber,w,h),
              raiButton("5", Colors.amber,w,h),
              raiButton("6", Colors.amber,w,h),
              raiButton("*", Colors.blueAccent,w,h),
            ],
          ),
          Row(
            children: [
              raiButton("1", Colors.amber,w,h),
              raiButton("2", Colors.amber,w,h),
              raiButton("3", Colors.amber,w,h),
              raiButton("%", Colors.blueAccent,w,h),
            ],
          ),
          Row(
            children: [
              raiButton("0", Colors.amber,w,h),
              raiButton("00", Colors.amber,w,h),
              raiButton(".", Colors.amber,w,h),
              raiButton("=", Colors.deepOrange,w,h),
            ],
          ),
        ],
      ),
    );
  }
}