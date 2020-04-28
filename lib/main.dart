import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash().then(
            (status){
          if(status){
            replaceMain();
          }
          else{
            return;
          }
        }
    );
  }

  Future<bool> splash()async{
    await Future.delayed(Duration(milliseconds: 2000));
    return true;
  }

  void replaceMain(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => MainApp()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Opacity(
                  opacity: 1,
                  child: Image.asset("assets/loader.png")
              )
            ],
          )
      ),
    );
  }
}


class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Аббасов В.Э. ИКБО-03-18 лаба 1"), backgroundColor: Colors.black),
        backgroundColor: Colors.black,
        body:
        ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 1000000,
            itemBuilder:
                (BuildContext context, int index){
              if(index.isOdd){
                return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const FlutterLogo(),
                        Text(Translater().fromIntToString(index))
                      ],
                    )
                );
              }
              else {
                return Container(
                    color: Colors.grey,
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const FlutterLogo(),
                        Text(Translater().fromIntToString(index))
                      ],

                    )
                );
              }
            }
        )
    );
  }
}

class Translater{
  var unit = ["один", "два", "три", "четыре", "пять", "шесть", "семь", "восемь", "девять"];
  var dozens= ["десять", "двадцать", "тридцать", "сорок", "пятьдесят", "шестьдесят", "семьдесят", "восемьдесят", "девяносто"];
  var from11to19= ["одиннадцать", "двенадцать", "тринадцать", "четырнадцать", "пятнадцать", "шестнадцать", "семнадцать", "восемнадцать", "девятнадцать"];
  var hundred = ["сто", "двести", "триста", "четыреста", "пятьсот", "шетьсот", "семьсот", "восемьсот", "девятьсот"];
  String fromIntToString(int number){
    String myStrNum = "";
    int num = number;
    myStrNum = myStrNum + threeDigits(num % 1000);
    num = (num ~/ 1000).toInt();
    if(num != 0 && num % 1000 != 0){
      myStrNum = threeDigits(num%1000) + " тысяч " + myStrNum;
    }
    num = (num ~/ 1000).toInt();
    if(num != 0){
      myStrNum = threeDigits(num%1000) + " миллион " + myStrNum;
    }
    return myStrNum;
  }
  String threeDigits(int thDig){
    String shortStrDig = "";
    int digits = 0;

//переводим сотни
    digits=(thDig~/100).toInt();
    if(digits!=0){
      shortStrDig=hundred[digits-1];
    }

//переводим десятки и единицы
    thDig=thDig%100; //осталось только двузначное число

//число больше или равно 20
    if (thDig>=20){
      digits = (thDig~/10).toInt();
      shortStrDig = shortStrDig + " " + dozens[digits-1];

      digits = thDig%10;
      if(digits!=0)
        shortStrDig = shortStrDig + " " + unit[digits-1];
    }
//число от 11 до 19
    else if(thDig>10 && thDig < 20){
      digits = thDig%10;
      shortStrDig = shortStrDig + " " + from11to19[digits-1];
    }
//число от 1 до 9
    else if (thDig<10 && thDig!=0){
      digits = thDig;
      shortStrDig = shortStrDig + " " + unit[digits-1];
    }
//число 10
    else if(thDig==10){
      shortStrDig = shortStrDig + " " + dozens[0];
    }

    shortStrDig= shortStrDig.trim();

    return shortStrDig;
  }
}