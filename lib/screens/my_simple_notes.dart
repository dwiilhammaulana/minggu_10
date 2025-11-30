import 'package:flutter/material.dart';
import 'package:minggu_10/database/database_helper.dart';
import 'package:minggu_10/models/note_model.dart';

class MySimpleNotes extends StatefulWidget {
  const MySimpleNotes({super.key});

  @override
  State<MySimpleNotes> createState() => _MySimpleNotesState();
}

class _MySimpleNotesState extends State<MySimpleNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Notes dengan SQLite'),
      ),
      body: FutureBuilder<List<Note>>(
        future: DatabaseHelper.instance.readAllNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Note note = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await DatabaseHelper.instance.delete(note.id!);
                      setState(() {}); // Refresh UI
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await DatabaseHelper.instance.create(
            Note(
              title: 'Catatan Baru',
              content: 'Isi catatan otomatis pada ${DateTime.now()}',
            ),
          );
          setState(() {}); // Refresh UI
        },
      ),
    );
  }
}
