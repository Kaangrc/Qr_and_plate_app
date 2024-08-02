import 'package:ar_app/QrGenerator/qrgenerator_page.dart';
import 'package:ar_app/adressReader/address_reader_page.dart';
import 'package:ar_app/car/plate_reader_page.dart';
import 'package:ar_app/qrreader_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final TextStyle c =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("HOME"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
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
                  MaterialPageRoute(builder: (context) => QrgeneratorPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.qr_code, size: 30),
                      SizedBox(width: 16),
                      Text('Qr Generator ',
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
                  MaterialPageRoute(builder: (context) => QrreaderPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.qr_code_scanner, size: 30),
                      SizedBox(width: 16),
                      Text('Qr Reader', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressReaderPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 30),
                      SizedBox(width: 16),
                      Text('Address Reader',
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
                  MaterialPageRoute(builder: (context) => PlateReaderPage()),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.car_repair, size: 30),
                      SizedBox(width: 16),
                      Text('Car Plate Reader',
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
