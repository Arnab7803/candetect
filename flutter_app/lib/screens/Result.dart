import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;

class ProcessPage extends StatefulWidget {
  static const routeName = '/process';
  @override
  _ProcessPageState createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  bool _isProcessing = false;
  late String _predictedClass;

  Future<void> _classifyImage(File? arg) async {
    final endpoint =
        'https://us-central1-aiplatform.googleapis.com/v1/projects/384058755198/locations/us-central1/endpoints/4871535800442945536:predict';
    final headers = {
      'Authorization':
          'ya29.a0Ael9sCN4eS9xgBa6CFE4oeLwMrTCG97mxLLHvbAwgvyLv7F_zN7_yNGxfrYYne2xuhqjSohEbjqLFK6S4AiV4VywMcDwfhoisMOCDip2Qsu7DixCeuBEXdwF1D-kyC5uWtHdyw2p-zCHov4oSzYd3__-8SGuyrUVaCgYKAcISARESFQF4udJhe-yn2AdpUaMIDTTfQciYYg0167',
      'Content-Type': 'application/json'
    };

    final bytes = await arg!.readAsBytes();
    final base64Image = base64Encode(bytes);
    final body = jsonEncode({
      'instances': [
        {'content': base64Image}
      ],
      'parameters': {'confidenceThreshold': 0.5, 'maxPredictions': 5}
    });

    final response =
        await http.post(Uri.parse(endpoint), headers: headers, body: body);
    final response2 = await http.get(Uri.parse(endpoint), headers: headers);

    if (response2.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response2.body);
      setState(() {
        _predictedClass = data['predictions'][0]['displayName'];
      });
    } else {
      throw Exception('Failed to predict image class');
    }
  }

  void _processImageCallback(File? arg) async {
    setState(() {
      _isProcessing = true;
    });

    await _classifyImage(arg).then((_) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Processing Complete'),
          content: Text('Results : $_predictedClass'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });

    setState(() {
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final File? arg = ModalRoute.of(context)!.settings.arguments as File?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Processing Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Processing Image'),
            SizedBox(height: 16.0),
            if (_isProcessing)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => _processImageCallback(arg),
                child: Text('Process Image'),
              ),
          ],
        ),
      ),
    );
  }
}
