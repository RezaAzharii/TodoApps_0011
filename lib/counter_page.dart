import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  List<String> daftarCounter = [];
  int counter = 1;

  void tambahCounter() {
    setState(() {
      daftarCounter.add(counter.toString());
      counter += 1;
    });
  }

  void kurangCounter() {
    if (counter > 1 && daftarCounter.isNotEmpty) {
      setState(() {
        daftarCounter.removeLast();
        counter-- ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter Page")),
      body:
          (daftarCounter.isEmpty)
              ? Center(
                child: Text(
                  "Data Kosong",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: daftarCounter.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(daftarCounter[index]));
                },
              ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          FloatingActionButton(
            onPressed: () {
              tambahCounter();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              kurangCounter();
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
