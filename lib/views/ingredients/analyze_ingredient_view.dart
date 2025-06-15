import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AnalyzeIngredientView extends StatefulWidget {
  AnalyzeIngredientView({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyBNl9w9jwdf4MNGqjlrsvOlF_Mq1i0FirU',
  );

  @override
  AnalyzeIngredientViewState createState() => AnalyzeIngredientViewState();
}

class AnalyzeIngredientViewState extends State<AnalyzeIngredientView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        return Scaffold(
          body: (snapshot.connectionState == ConnectionState.done)
              ? Column(
                  children: [
                    CameraPreview(_controller),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.flash_off),
                            onPressed: () {
                              _controller.setFlashMode(FlashMode.off);
                            },
                          ),
                          const SizedBox(width: 16),
                          FilledButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(24),
                            ),
                            child: const Icon(Icons.camera, size: 36),
                            onPressed: () async {
                              final image = await _controller.takePicture();
                              await analyzeImage(image);
                            },
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.flash_on),
                            onPressed: () {
                              _controller.setFlashMode(FlashMode.torch);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<void> analyzeImage(XFile image) async {
    final bytes = await image.readAsBytes();

    final response = await widget.model.generateContent(
      [
        Content.multi([
          DataPart('image/jpeg', bytes),
          TextPart(
              'Analyze the contents of the image and determine the name of the product or food item, its brand name, the size of a single serving in grams and the nutritional values per 100 grams. If a nutritional values table is displayed in the image, use those values. Otherwise try to estimate the values based on what you see in the image.'),
        ]),
      ],
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema.object(properties: {
          'name': Schema.string(nullable: true),
          'brandName': Schema.string(nullable: true),
          'nutritionalValues': Schema.object(
            properties: {
              'energy': Schema.object(properties: {
                'kiloJoules': Schema.number(nullable: true),
                'kiloCalories': Schema.number(nullable: true),
              }),
              'fats': Schema.object(properties: {
                'total': Schema.number(nullable: true),
                'saturated': Schema.number(nullable: true),
              }),
              'carbohydrates': Schema.object(properties: {
                'total': Schema.number(nullable: true),
                'sugar': Schema.number(nullable: true),
                'fiber': Schema.number(nullable: true),
              }),
              'protein': Schema.number(nullable: true),
              'salt': Schema.number(nullable: true),
            },
          ),
          'portionSize': Schema.number(nullable: true),
        }),
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Analysis Result'),
          content: Text(
            JsonEncoder.withIndent('  ')
                .convert(jsonDecode(response.text ?? "{}")),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
