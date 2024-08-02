import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TextQrPage extends StatefulWidget {
  @override
  _TextQrPageState createState() => _TextQrPageState();
}

class _TextQrPageState extends State<TextQrPage> {
  final TextEditingController _textController = TextEditingController();
  String? _qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.amber,
        title: Text("Text'ten QR Oluştur"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _qrData != null
                ? QrImageView(
                    data: _qrData!,
                    size: 200,
                  )
                : Text("Text girin"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _textController,
                maxLength: 255,
                decoration: InputDecoration(
                  labelText: 'Text',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Metni doğrudan QR koduna yazdır
                  _qrData = _textController.text;
                });
              },
              child: Text("QR Kod Oluştur"),
            ),
          ],
        ),
      ),
    );
  }
}
