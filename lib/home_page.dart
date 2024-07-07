import 'package:flutter/material.dart';
import 'contact.dart';
import 'contact_list_page.dart';
import 'about_page.dart'; // Import AboutPage

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = [];
  int selectedIndex = -1;

  void handleEdit(int index) {
    setState(() {
      selectedIndex = index;
      nameController.text = contacts[index].name;
      contactController.text = contacts[index].contact;
    });
  }

  void handleDelete(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kontak Ku',
          style: TextStyle(color: Color.fromARGB(255, 26, 1, 251)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'nama kontak',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 13,
              decoration: const InputDecoration(
                hintText: 'nomor kontak',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        if (selectedIndex == -1) {
                          contacts.add(Contact(name: name, contact: contact));
                        } else {
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          selectedIndex = -1;
                        }
                        nameController.text = '';
                        contactController.text = '';
                      });
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                      255,
                      0,
                      248,
                      4,
                    )),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedIndex != -1 &&
                        selectedIndex < contacts.length) {
                      setState(() {
                        contacts.removeAt(selectedIndex);
                        selectedIndex = -1;
                      });
                    }
                  },
                  child: const Text(
                    'Hapus',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                      255,
                      255,
                      0,
                      0,
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final updatedContacts = await Navigator.push<List<Contact>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactListPage(
                      contacts: contacts,
                      onTapEdit: handleEdit,
                      onTapDelete: handleDelete,
                    ),
                  ),
                );

                if (updatedContacts != null) {
                  setState(() {
                    contacts = updatedContacts;
                  });
                }
              },
              child: const Text('Lihat Kontak'),
            ),
          ],
        ),
      ),
    );
  }
}
