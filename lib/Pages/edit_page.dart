// import 'package:diary_app/Pages/home_page.dart';
import 'package:diary_app/database/gpt_db.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final myController = TextEditingController();
  final dbHelper = DatabaseHelper();
  var isFavorite = 0;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Add Diary",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextField(
            controller: myController,
            decoration: InputDecoration(
              hintText: "Add Note",
              labelText: "How was your day?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 10,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  const snackBar = SnackBar(
                    // margin: EdgeInsets.all(8),
                    backgroundColor: Colors.deepPurple,
                    content: Text('Diary Saved !!'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  await dbHelper.insertEntry(DiaryEntry(
                    date: DateTime.now().toString(),
                    content: myController.text,
                    isFavorite: isFavorite,
                  ));
                  // Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isFavorite == 0 ? isFavorite = 1 : isFavorite = 0;
                  });

                  await dbHelper.updateEntry(DiaryEntry(
                    date: DateTime.now().toString(),
                    content: myController.text,
                    isFavorite: isFavorite,
                  ));
                },
                child: isFavorite == 1
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.blue, // <-- Button color
              foregroundColor: Colors.red, // <-- Splash color
            ),
            child: const Icon(
              Icons.keyboard_voice,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
