import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrlQrPage extends StatefulWidget {
  @override
  _UrlQrPageState createState() => _UrlQrPageState();
}

class _UrlQrPageState extends State<UrlQrPage> {
  final TextEditingController _urlController = TextEditingController();
  String? _qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.amber,
        title: Text("URL'den QR Oluştur"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _qrData != null
                ? QrImageView(
                    data: _qrData!,
                    version: QrVersions.auto,
                    size: 200.0,
                  )
                : Text("URL girin"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrData = _urlController.text;
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
