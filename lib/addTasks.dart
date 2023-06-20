// import 'dart:ffi';
//
// import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database/sqlite_database.dart';

class addtasks extends StatefulWidget {
  @override
  _addtaskseState createState() => _addtaskseState();
}

class _addtaskseState extends State<addtasks> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController buttonController = TextEditingController();
  String Timeline='';
  TextEditingController Title = TextEditingController();
  TextEditingController Detail = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        Timeline = _formatTime(selectedTime);
      });
    }
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hourOfPeriod;
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  // late String selectedItem = '';
  // List<String> items = ['Option 1', 'Option 2', 'Option 3'];
  late List<String> items = [];

  late SqliteService _sqliteService;
  @override
  void initState() {
    super.initState();
    this._sqliteService= SqliteService();

    // items = widget.items;
    buttonController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  String? selectedValue;
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD TASKS'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(keyboardType: TextInputType.multiline,
                maxLines: null,
            controller: Title,
            decoration: InputDecoration(
              hintText: 'Input Title',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),),),
            SizedBox(height: 12,),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              height: 200,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: Detail,
                decoration: InputDecoration(
                  hintText: 'Your Mission Details',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 12,),
            Text(Timeline),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    icon: Icon(Icons.access_alarm)),

              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              width: 150,
              child: TextButton(
                onPressed: () {
                  String _title = Title.text;
                  String _detail = Detail.text;
                  infor information = new infor(_title,_detail,selectedTime);
                  Navigator.of(context).pop(information);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
              ),
            ),

          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
class infor{
  final String Title;
  final String Detail;
  final TimeOfDay Time;
  infor(this.Title, this.Detail, this.Time);
}
