import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:camera/camera.dart';
import 'car_result.dart';

class PlateReaderPage extends StatefulWidget {
  const PlateReaderPage({super.key});

  @override
  State<PlateReaderPage> createState() => _PlateReaderPageState();
}

class _PlateReaderPageState extends State<PlateReaderPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();
    _cameraController.startImageStream(_processCameraImage);
  }

  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_isProcessing) return;

    _isProcessing = true;

    try {
      // Convert CameraImage to InputImage
      final inputImage = _convertCameraImageToInputImage(cameraImage);

      // Process the image file with Google ML Kit's text recognizer.
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);

      // Extract the text from the recognized text.
      String text = '';
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          text += line.text + '\n';
        }
      }

      // Use regex to find Turkish license plates.
      final regex = RegExp(r'\b[0-9]{2} [A-Z]{1,3} [0-9]{2,4}\b');
      final matches = regex.allMatches(text);

      if (matches.isNotEmpty) {
        final plate = matches.first.group(0) ?? '';

        if (plate.isNotEmpty) {
          // Stop the image stream
          _cameraController.stopImageStream();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarResult(address: plate),
            ),
          );
          return;
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  InputImage _convertCameraImageToInputImage(CameraImage cameraImage) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
    final camera = _cameraController.description;
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.nv21;

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: cameraImage.planes.first.bytesPerRow,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        title: const Text('Plate Reader',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
