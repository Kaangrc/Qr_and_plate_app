import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatelessWidget {
  final String address;

  ResultScreen({required this.address});

  Future<void> _launchMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$query';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        title: const Text('Detected Address',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Detected Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SelectableText(
              address,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: address));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Address copied to clipboard')),
                );
              },
              child: Text('Copy Address'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _launchMaps(address),
              child: Text('Open in Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
