import 'package:flutter/material.dart';
import 'package:todolist/DetailScreen.dart';
import 'package:todolist/addTasks.dart';
import './Icons/flutter_icons.dart';
import 'database/sqlite_database.dart';

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
  SqliteService db = SqliteService();
  void deleteItem(int index) {
    setState(() {
      catalog.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _sqliteService = SqliteService();
    _sqliteService.initializeDB();
    initializeCatalog();
  }

  Future<void> initializeCatalog() async {
    List<String> catalogData = (await db.getAllTaskNames()).cast<String>();
    setState(() {
      catalog = catalogData;
    });

  }

  void showConfirmationDialog(BuildContext context, String title,
      String message, VoidCallback onConfirm, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                db.deleteTask(name);
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  List<String> catalog = [];

  List<Widget> buildGridItems(BuildContext context) {
    List<Widget> gridItems = [];
    for (int i = 0; i < catalog.length; i++) {
      Widget item = buildItemCard(
        context,
        Icons.ac_unit, // Replace with the desired icon
        catalog[i],
        'Detail for ${catalog[i]}', // Replace with the desired detail
        () => deleteItem(i),
      );
      gridItems.add(item);
    }

    return gridItems;
  }

  Container buildItemCard(
    BuildContext context,
    IconData icon,
    String name,
    String detail,
    VoidCallback onDelete,
  ) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(title: name),
            ),
          );
        },
        onLongPress: () {
          showConfirmationDialog(context, 'Delete Catalog',
              'Do you want to delete this ${name}?', onDelete, name);
        },
        child: Card(
            elevation: 20,
            margin: EdgeInsets.all(10),
            color: Colors.lightGreenAccent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Icon(
                    icon,
                    size: 50,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(detail),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> gridItems = buildGridItems(context);
    infor inforTask = infor('', '', TimeOfDay.now());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            String Name =
                await _showTextEntryDialog(context, catalog) as String;
            if (Name != '') {
              SqliteService db = SqliteService();
              Task _task = Task(Name);
              db.createTask(_task);
              catalog = await db.getAllTaskNames() as List<String>;
              setState(() {});
            }

          },
          icon: Icon(Icons.list),
        ),
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: gridItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, _createRoute()).then((result) async {
            if (result != null && result is infor) {
              print(result.Title);
              inforTask = result;
                if (inforTask.Title != '') {
                  SqliteService db = SqliteService();
                  Task _task = Task(inforTask.Title);
                  db.createTask(_task);
                  catalog = await db.getAllTaskNames() as List<String>;
                }
              setState(() {});
            }
          });
        },
        child: Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onCellTap(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(title: title),
      ),
    );
  }

  Widget buildCell(BuildContext context, int index) {
    String title = catalog[index];

    return GestureDetector(
      onTap: () => onCellTap(context, title),
      child: GridTile(
        child: Card(
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return addtasks();
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

Future<String> _showTextEntryDialog(
    BuildContext context, List<String> catalog) async {
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
                    if (catalog.contains(inputText)) {
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
