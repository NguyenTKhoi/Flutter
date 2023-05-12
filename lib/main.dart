import 'package:flutter/material.dart';

import 'addTaks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'To Do List App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _Reprint(String name) {
    setState(() {
      newItemCard.add(_buildItemCard(Icons.coffee, name, '0 Task'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text(widget.title),
      ),
      body: _buildGridview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String Name = await _showTextEntryDialog(context) as String;
          if (Name != '') {
            _Reprint(Name);
          }
        },
        child: Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Container _buildItemCard(IconData icon, String name, String detail) {
  return Container(
      child: Card(
    margin: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 50,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            '$name',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Text('$detail'),
      ],
    ),
  ));
}

List<Widget> newItemCard = [
  _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
];
Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 200,
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      children: [
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
        _buildItemCard(Icons.co_present, 'All', '24 Tasks'),
      ],
    );

Widget _buildGridview() => GridView.builder(
      itemCount: newItemCard.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of columns
        crossAxisSpacing: 10, // spacing between columns
        mainAxisSpacing: 10, // spacing between rows
      ),
      itemBuilder: (BuildContext context, int index) {
        return newItemCard[index];
      },
    );

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return addtaks();
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation,
        Widget child) {
      return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}

showAddDialog(BuildContext context) {
  String inputText = '';
  return AlertDialog(
    title: Text('Input SomeThing'),
    content: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      autofocus: true,
      onChanged: (value) {
        inputText = value;
      },
    ),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel')),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Select')),
    ],
  );
}

// Future<NameTask> futureValue = showAddDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return dialog;
//     }
// );

// Future<String> _showTextEntryDialog(BuildContext context) async {
//   String inputText = '';
//
//   await showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Input Something'),
//         content: TextField(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//
//           ),
//           autofocus: true,
//           onChanged: (value) {
//             inputText = value;
//           },
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text('Select'),
//             onPressed: () {
//               //newItemCard.add(_buildItemCard(Icons.coffee, inputText, '0 Task'));
//               if(inputText != ''){
//               Navigator.of(context).pop(inputText);
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
//   return inputText;
// }

Future<String> _showTextEntryDialog(BuildContext context) async {
  String inputText = '';
  String errorMessage = '';

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Input Something'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                      errorMessage = '';
                    });
                  },
                ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Select'),
                onPressed: () {
                  if (inputText.isNotEmpty) {
                    Navigator.of(context).pop(inputText);
                  } else {
                    setState(() {
                      errorMessage = 'Please do not leave it blank';
                    });
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
  return inputText;
}
