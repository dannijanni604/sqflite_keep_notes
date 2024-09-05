import 'package:flutter/material.dart';
import 'package:sqflite_keep_notes/config/db_handler.dart';
import 'package:sqflite_keep_notes/models/notes.dart';
import 'package:sqflite_keep_notes/utils/custom_widgets/app_snackbar.dart';
import 'package:sqflite_keep_notes/utils/custom_widgets/custom_app_bar.dart';
import 'package:sqflite_keep_notes/views/add_notes_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DbHelper dbHelper;
  late Future<List<Notes>> notesList;

  loadData() async {
    notesList = dbHelper.getNotes();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            title: 'My Notes',
            icon: Icons.add,
            onActionTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddNotesView()));
            }),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Expanded(
                  child: FutureBuilder(
                      future: notesList,
                      builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
                        if (snapshot.hasData) {
                          var reversedList = snapshot.data!.reversed.toList();
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => Card(
                                  child: ListTile(
                                      title: Text(reversedList[index].title),
                                      subtitle: Text(reversedList[index].description),
                                      trailing: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        GestureDetector(
                                            onTap: () {
                                              int id = reversedList[index].id ?? 0;
                                              dbHelper.deleteNote(id).onError(
                                                    (error, stackTrace) => errorSnackBar(context: context, error: error.toString()),
                                                  );
                                              setState(() {
                                                loadData();
                                              });
                                            },
                                            child: const Icon(Icons.delete_outline_outlined)),
                                        Text(reversedList[index].createdAt)
                                      ]))));
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }))
            ])));
  }
}
