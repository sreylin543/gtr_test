import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 97, 12, 26)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  dynamic scheduale = [
    {"Name": "Morning", "Date": "2025-01-01", "Time": "10:00"},
    {"Name": "Afternoon", "Date": "2025-01-01", "Time": "03:00"},
    {"Name": "Evening", "Date": "2025-01-01", "Time": "07:00"},
  ];

  TextEditingController name_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
         
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: name_controller,
                  decoration: const InputDecoration(
                      hintText: "Enter schedule name"),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  String name = name_controller.text.trim();

                  if (name.isEmpty) return;

                  dynamic data = {
                    "Name": name,
                    "Date": "0000-00-00",
                    "Time": "00:00",
                  };

                  scheduale.add(data);
                  name_controller.clear();
                  setState(() {});
                },
                child: const Text("Add"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // LIST OF SCHEDULES
          Expanded(
            child: ListView.builder(
              itemCount: scheduale.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Text("Schedule ${index + 1}: "),
                      const SizedBox(width: 10),

                      // NAME
                      Text("${scheduale[index]["Name"]}  "),

                      // DATE BUTTON
                      OutlinedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String newDate =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                            scheduale[index]["Date"] = newDate;
                            setState(() {});
                          }
                        },
                        child: Text("${scheduale[index]["Date"]}"),
                      ),

                      const SizedBox(width: 8),

                      // TIME BUTTON
                      OutlinedButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            final String formattedTime =
                                "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";

                            scheduale[index]["Time"] = formattedTime;
                            setState(() {});
                          }
                        },
                        child: Text("${scheduale[index]["Time"]}"),
                      ),

                      const SizedBox(width: 8),

                      // DELETE BUTTON
                      OutlinedButton(
                        onPressed: () {
                          scheduale.removeAt(index);
                          setState(() {});
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}






            