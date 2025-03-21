import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime? selectedDate;

  List<Map<String, dynamic>> daftarTask = [];
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  void addTask() {
    if (key.currentState!.validate()) {
      setState(() {
        daftarTask.add({
          "task": taskController.text,
          "deadline": selectedDate,
          "status": false,
        });
        taskController.clear();
        selectedDate = null;
        _autoValidate = AutovalidateMode.disabled;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task berhasil ditambahkan!")));
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

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
                            selectedDate != null
                                ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year} ${selectedDate!.hour}:${selectedDate!.minute}"
                                : "Pilih Deadline",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[200],
                            ),
                          ),
                          if (selectedDate == null &&
                              _autoValidate ==
                                  AutovalidateMode.onUserInteraction)
                            Text(
                              "Silakan pilih deadline terlebih dahulu!",
                              style: TextStyle(fontSize: 14, color: Colors.red),
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: taskController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Task Masih Kosong";
                            }
                            return null;
                          },
                          autovalidateMode: _autoValidate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Task",
                            hintText: "Masukkan Task",
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(16),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.pinkAccent),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (key.currentState!.validate() &&
                              selectedDate != null) {
                            addTask();
                          } else {
                            setState(() {
                              _autoValidate =
                                  AutovalidateMode.onUserInteraction;
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.pinkAccent,
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "List Tasks",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: daftarTask.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF3A3A3A),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                daftarTask[index]["task"],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink[100],
                                ),
                              ),
                              Text(
                                "Deadline: ${daftarTask[index]["deadline"]!.day}-${daftarTask[index]["deadline"]!.month}-${daftarTask[index]["deadline"]!.year} ${daftarTask[index]["deadline"]!.hour}:${daftarTask[index]["deadline"]!.minute}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[200],
                                ),
                              ),
                              Text(
                                daftarTask[index]["status"]
                                    ? "Selesai"
                                    : "Belum Selesai",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      daftarTask[index]["status"]
                                          ? Colors.green[300]
                                          : Colors.red[300],
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            activeColor: Colors.pinkAccent,
                            value: daftarTask[index]["status"],
                            onChanged: (bool? value) {
                              setState(() {
                                daftarTask[index]["status"] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
