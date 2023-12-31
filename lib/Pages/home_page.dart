// import 'package:diary_app/Pages/diary_card.dart';
import 'package:diary_app/Pages/diary_card.dart';
import 'package:diary_app/Pages/edit_page.dart';
import 'package:diary_app/Pages/fav_page.dart';
import 'package:diary_app/database/gpt_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  late List<DiaryEntry> entries;
  final dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    entries = [];
    fetchData();
  }

  Future<void> fetchData() async {
    entries = await dbHelper.getAllEntries();
    entries.sort((a, b) => b.date.compareTo(a.date));
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    Widget currPage;
    var fabShow = true;
    switch (selectedIndex) {
      case 0:
        currPage = _diaryList();
        fabShow = true;
        break;
      case 1:
        currPage = _favPage();
        fabShow = false;
        break;
      case 2:
        currPage = _account();
        fabShow = false;
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(formatter),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              fetchData();
            },
            icon: const Icon(Icons.replay_outlined),
          ),
          IconButton(
            onPressed: () async {
              dbHelper.deleteAllEntries();
              fetchData();
            },
            icon: Icon(Icons.delete),
          ),
        ],
        title: const Text("Your daily dairy"),
        backgroundColor: Colors.yellow,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        selectedIndex: selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_border),
            label: "Favorite",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: "Account",
          ),
        ],
      ),
      floatingActionButton: fabShow
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPage(),
                  ),
                );
              },
            )
          : null,
      body: currPage,
    );
  }

  Widget _diaryList() {
    return entries.length != 0
        ? ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              var entry = entries[index];
              // DateTime now = DateTime.parse(entry.date);
              // String formattedDate = DateFormat('MMM').format(now);
              return DiaryCard(note: entry);
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _account() {
    return const Center(
      child: Text("This is the account page"),
    );
  }

  Widget _favPage() {
    return entries.length != 0
        ? ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              var entry = entries[index];
              // DateTime now = DateTime.parse(entry.date);
              // String formattedDate = DateFormat('MMM').format(now);
              if (entry.isFavorite == 1) {
                return DiaryCard(note: entry);
              }
              return Container();
            },
          )
        : const Center(child: Text("No favorites"));
  }
}
