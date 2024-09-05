import 'package:flutter/material.dart';
import 'package:sqflite_keep_notes/utils/custom_widgets/app_snackbar.dart';
import 'package:sqflite_keep_notes/utils/custom_widgets/custom_app_bar.dart';
import 'package:sqflite_keep_notes/views/home_view.dart';
import '../config/db_handler.dart';
import '../models/notes.dart';

class AddNotesView extends StatelessWidget {
  const AddNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final forkKey = GlobalKey<FormState>();
    DbHelper dbHelper = DbHelper();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
        appBar: customAppBar(title: 'Add Notes'),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: forkKey,
                child: Column(children: [
                  TextFormField(
                      decoration: InputDecoration(isDense: true, hintText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(isDense: true, hintText: 'Description', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (forkKey.currentState!.validate()) {
                          dbHelper.insert(Notes(title: titleController.text, description: descriptionController.text, createdAt: TimeOfDay.now().format(context))).then(
                            (value) {
                              successSnackBar(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
                            },
                          ).onError((error, stackTrace) => errorSnackBar(context: context, error: error.toString()));
                        }
                      },
                      child: const Text('Submit'))
                ]))));
  }
}
