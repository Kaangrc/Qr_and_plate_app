import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContactQrPage extends StatefulWidget {
  @override
  _ContactQrPageState createState() => _ContactQrPageState();
}

class _ContactQrPageState extends State<ContactQrPage> {
  Contact? _selectedContact;
  String? _qrData;

  Future<void> _requestPermissions() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
  }

  Future<void> _pickContact() async {
    await _requestPermissions();
    try {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      Contact? selectedContact = await showDialog<Contact>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Kişi Seç'),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                children: contacts.map((contact) {
                  return ListTile(
                    title: Text(contact.displayName ?? 'No Name'),
                    subtitle: Text(contact.phones?.isNotEmpty == true
                        ? contact.phones!.first.value!
                        : 'No Phone'),
                    onTap: () {
                      Navigator.of(context).pop(contact);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      );

      if (selectedContact != null) {
        setState(() {
          _selectedContact = selectedContact;
          _qrData =
              'Name: ${selectedContact.displayName}, Phone: ${selectedContact.phones?.first.value}';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.amber,
        title: Text("Contact to QR"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedContact != null) ...[
              Card(
                elevation: 5,
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${_selectedContact!.displayName}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Phone: ${_selectedContact!.phones?.isNotEmpty == true ? _selectedContact!.phones!.first.value : 'No Phone'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      _qrData != null
                          ? QrImageView(
                              data: _qrData!,
                              version: QrVersions.auto,
                              size: 200.0,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Text("Bir kişi seçin"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickContact,
                child: Text("Rehberden Kişi Seç"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
