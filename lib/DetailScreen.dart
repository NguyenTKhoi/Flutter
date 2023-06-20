import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {
  final String title;
  DetailScreen({required this.title});
  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Container(
        width: double.infinity,
        height: 100,
        child: Card(
          elevation: 20,
          margin: EdgeInsets.all(10),
          color: Colors.lightGreenAccent,
          child: Container(
            child: Column(
              children: [
                Text('data'),
                Container(
                  child: Row(
                    children: [
                      Column(children: [
                        Text('Task1'),
                        Text('start: 9h, end: 12h'),
                      ],),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
// Widget infomation =
