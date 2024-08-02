
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  String? _qrResult;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Kodu Tara'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: (QRViewController controller) {
                _controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    _qrResult = scanData.code;
                    controller.stopCamera(); // Stop the camera after scanning
                  });
                }, onError: (error) {
                  // Handle any errors that occur while scanning
                  print('Error scanning QR code: $error');
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: _qrResult != null
                  ? Card(
                      elevation: 5,
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'QR Kodunda Bulunan Bilgiler:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _qrResult!,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Restart the camera when the button is pressed
                                _controller?.resumeCamera();
                                setState(() {
                                  _qrResult = null;
                                });
                              },
                              child: Text('Tekrar Tara'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text('QR kodunu tarayın'),
            ),
          ),
        ],
      ),
    );
  }
}
