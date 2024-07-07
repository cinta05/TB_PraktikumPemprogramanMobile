import 'package:flutter/material.dart';
import 'package:contacts_app/contact.dart';

class ContactListPage extends StatelessWidget {
  final List<Contact> contacts;
  final Function(int) onTapEdit;
  final Function(int) onTapDelete;

  const ContactListPage({
    Key? key,
    required this.contacts,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),
      body: contacts.isEmpty
          ? Center(
              child: Text(
                'Tidak ada kontak...',
                style: TextStyle(fontSize: 22),
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(contacts[index].name),
                subtitle: Text(contacts[index].contact),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke HomePage
                        onTapEdit(index); // Panggil onTapEdit untuk edit kontak
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.delete),
                    //   onPressed: () => onTapDelete(
                    //       index), // Panggil onTapDelete untuk hapus kontak
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
