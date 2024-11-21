// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'bndbox.dart';
// import 'camera.dart';
// import 'dart:math' as math;
//
// class DetectScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   final String model;
//
//   const DetectScreen({super.key, required this.cameras, required this.model});
//
//   @override
//   State<DetectScreen> createState() => _DetectScreenState();
// }
//
// class _DetectScreenState extends State<DetectScreen> {
//   List<dynamic>? _recognitions;
//   int _imageHeight = 0;
//   int _imageWidth = 0;
//
//   setRecognitions(recognitions, imageHeight, imageWidth) {
//     setState(() {
//       _recognitions = recognitions;
//       _imageHeight = imageHeight;
//       _imageWidth = imageWidth;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Camera(
//             widget.cameras,
//             widget.model,
//             setRecognitions,
//           ),
//           BndBox(
//               _recognitions ?? [],
//               math.max(_imageHeight, _imageWidth),
//               math.min(_imageHeight, _imageWidth),
//               screen.height,
//               screen.width,
//               widget.model),
//         ],
//       ),
//     );
//   }
// }

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'bndbox.dart';
import 'camera.dart';
import 'dart:math' as math;

class DetectScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String model;
  final Function(List<dynamic>) onRecognitions; // 콜백 추가

  const DetectScreen({
    super.key,
    required this.cameras,
    required this.model,
    required this.onRecognitions,
  });

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });

    widget.onRecognitions(_recognitions ?? []);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            widget.model,
            setRecognitions,
          ),
          BndBox(
            _recognitions ?? [],
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            widget.model,
          ),
        ],
      ),
    );
  }
}

