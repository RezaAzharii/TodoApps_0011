import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

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
                        onPressed:() {},
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