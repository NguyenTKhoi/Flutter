import 'package:flutter/material.dart';

class addtaks extends StatelessWidget{
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD TAKS'),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Where',
                ),
              ),
            )
          ],
        )
      ),
      backgroundColor: Colors.lightGreenAccent[100],
    );
  }
}

