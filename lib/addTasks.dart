import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addtasks extends StatefulWidget {
  addtasks({required this.items});
  final List<String> items;
  @override
  _addtaskseState createState() => _addtaskseState();
}

class _addtaskseState extends State<addtasks> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController buttonController = TextEditingController();

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
      });
    }
  }

  // late String selectedItem = '';
  // List<String> items = ['Option 1', 'Option 2', 'Option 3'];
  late List<String> items = [];
  @override
  void initState() {
    super.initState();
    items = widget.items;
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
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              height: 200,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Your Mission Details',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.calendar_month_outlined)),
                IconButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    icon: Icon(Icons.access_alarm)),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Catalog',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white60,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      padding: null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 8,
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 150,
              child: TextButton(
                onPressed: () {},
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
