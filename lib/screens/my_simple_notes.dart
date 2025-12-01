import 'package:flutter/material.dart';
import 'package:minggu_10/database/database_helper.dart';
import 'package:minggu_10/models/note_model.dart';

class MySimpleNotes extends StatefulWidget {
  const MySimpleNotes({super.key});

  @override
  State<MySimpleNotes> createState() => _MySimpleNotesState();
}

class _MySimpleNotesState extends State<MySimpleNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _showForm() {
    _titleController.clear();
    _contentController.clear();

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Judul Catatan'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(hintText: 'Isi Catatan'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Simpan Catatan"),
              onPressed: () async {
                String title = _titleController.text;
                String content = _contentController.text;

                if (title.isNotEmpty && content.isNotEmpty) {
                  await DatabaseHelper.instance.create(
                    Note(title: title, content: content),
                  );
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }

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
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DatabaseHelper.instance.delete(note.id!);
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _showForm,
      ),
    );
  }
}
