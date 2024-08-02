import 'package:flutter/material.dart';
import 'url_qr_page.dart';
import 'text_qr_page.dart';
import 'contact_qr_page.dart';

class QrgeneratorPage extends StatefulWidget {
  const QrgeneratorPage({super.key});

  @override
  State<QrgeneratorPage> createState() => _QrgeneratorPageState();
}

class _QrgeneratorPageState extends State<QrgeneratorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.amber,
        title: Text("QR Kod Üretici"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: const Color.fromARGB(255, 109, 107, 103),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactQrPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.contacts, size: 30),
                      SizedBox(width: 16),
                      Text('Rehber', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UrlQrPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.link, size: 30),
                      SizedBox(width: 16),
                      Text('Web Site Url',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextQrPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.text_fields, size: 30),
                      SizedBox(width: 16),
                      Text('Text QR Kod',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
