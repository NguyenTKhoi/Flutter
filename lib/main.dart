import 'package:flutter/material.dart';
import 'package:todolist/addTasks.dart';
import './Icons/flutter_icons.dart';

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
  void _Reprint(String name) {
    setState(() {
      newItemCard.add(_buildItemCard(Icons.coffee, name, '0 Task'));
    });
  }

  List<String> catalog = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            String Name = await _showTextEntryDialog(context,catalog) as String;
            if (Name != '') {
              _Reprint(Name);
              catalog.add(Name);
            }
          },
          icon: Icon(Icons.list),
        ),
        title: Text(widget.title),
      ),
      body: _buildGridview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // String Name = await _showTextEntryDialog(context) as String;
          // if (Name != '') {
          //   _Reprint(Name);
          // }
          Navigator.of(context).push(_createRoute(catalog));
        },
        child: Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Container _buildItemCard(IconData icon, String name, String detail) {
  return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
      child: Card(
        elevation: 20,
        margin: EdgeInsets.all(10),
        color: Colors.lightGreenAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              icon,
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
  _buildItemCard(MyFlutterApp.home, 'All', '24 Tasks'),
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

Route _createRoute(List<String> catalog) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return addtasks( items:catalog);
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



Future<String> _showTextEntryDialog(BuildContext context, List<String> catalog) async {
  String inputText = '';
  String errorMessage = '';

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Input Catalog'),
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
                    if(catalog.contains(inputText)){
                      setState(() {
                        errorMessage = 'Already have this catalog';
                      });
                    } else {
                      Navigator.of(context).pop(inputText);
                    }
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

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData pill =
      IconData(0xea60, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
