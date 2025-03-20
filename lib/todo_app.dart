import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime? selectedDate;

   void _showDatePicker() {
    BottomPicker.dateTime(
      pickerTitle: Text(
        "Pilih Tanggal & Waktu",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      buttonContent: Center(child: Text("Pilih")),
      onChange: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      onCloseButtonPressed: () {
        setState(() {
          selectedDate = null;
        });
      },
      minDateTime: DateTime.now(),
      maxDateTime: DateTime(2025, 12, 31),
      initialDateTime: selectedDate ?? DateTime.now(),
      bottomPickerTheme: BottomPickerTheme.heavyRain,
    ).show(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: Icon(Icons.menu),
        foregroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deadline : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Pilih Deadline",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _showDatePicker,
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.pinkAccent,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                ],
              )
            )
          ],
        ),
      ),
    );
  }
}