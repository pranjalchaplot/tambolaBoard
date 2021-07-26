import 'package:flutter/material.dart';
import './ticket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'TAMBOLA GAME SCREEN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<String>> tamBoard = List<List<String>>.generate(
      3, (i) => List<String>.generate(9, (i) => " "),
      growable: false);

  List<List<bool>> tamColor = List<List<bool>>.generate(
      3, (i) => List<bool>.generate(9, (i) => false),
      growable: false);

  var isON = true;
  void gen() {
    setState(() {
      TambolaTicketGenerator t = new TambolaTicketGenerator();
      tamBoard = t.Generate();
    });
  }

  void colorChanger(int i, int j) {
    setState(() {
      tamColor[i][j] = !tamColor[i][j];
      // jikso bhi click kara uska isOn change krdo
    });
  }

  @override
  void initState() {
    super.initState();
    gen();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> myRowChildren = [];
    List<List<Widget>> numbers = [];
    List<Widget> columnNumbers = [];
    for (int i = 1; i <= 10; i++) {
      for (int y = i; y <= i + 80; y += 10) {
        int currentNumber = y; // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
        columnNumbers.add(Container(
          height: 40,
          width: 28,
          //color: _hasBeenPressed ? Colors.black : Colors.greenAccent,
          child: TextButton(
              child: Text(
                '$currentNumber',
                style: TextStyle(fontSize: 10.5),
              ),
              onPressed: () {}),
        ));
      }
      numbers.add(columnNumbers);
      columnNumbers = [];
    }

    myRowChildren = numbers
        .map(
          (columns) => Card(
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,

              children: columns.map((n) {
                return Container(
                  child: n,
                );
              }).toList(),
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: myRowChildren,
            ),
          ),
          //SizedBox(height: 100.0,),
          Container(
            width: size.width,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Table(
                    border: TableBorder.all(
                      // style: BorderStyle.solid,
                      width: 0,
                    ),
                    children: [
                      for (int i = 0; i <= 2; i++)
                        TableRow(
                          // onSelectedChanged:
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          children: [
                            for (int j = 0; j <= 8; j++)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    // change this value using function
                                    child: TextButton(
                                      child: Text(
                                        tamBoard[i][j],
                                        style: TextStyle(
                                          color: tamColor[i][j]
                                              ? Colors.red
                                              : Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        colorChanger(i, j);
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ],
                        )
                    ],
                  ),
                ),
                // Container(
                //   child: OutlinedButton(
                //     child: Icon(
                //       Icons.replay_rounded,
                //       color: Colors.green,
                //     ),
                //     onPressed: () {
                //       gen();
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
