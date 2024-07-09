import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MaterialApp(
    title: 'Art Activity',
    home: ArtCanvas(),
  ));
}

class ArtCanvas extends StatefulWidget {
  @override
  _ArtCanvasState createState() => _ArtCanvasState();
}

class _ArtCanvasState extends State<ArtCanvas> {
  List<_Stroke> _strokes = [];
  double _currentThickness = 10.0;
  Color _currentColor = Colors.black; 
  Size canvasSize = Size(800, 600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Activity'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveImage,
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _selectColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _strokes.add(_Stroke(
                    color: _currentColor, 
                    thickness: _currentThickness,
                    points: [details.localPosition],
                  ));
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _strokes.last.points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _strokes.last.points.add(null);
                });
              },
              child: CustomPaint(
                painter: _ArtPainter(strokes: _strokes),
                size: Size.infinite,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _currentThickness,
                  min: 1.0,
                  max: 20.0,
                  onChanged: (value) {
                    setState(() {
                      _currentThickness = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _undo,
        child: Icon(Icons.clear),
      ),
    );
  }

  void _selectColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) {
                setState(() {
                  _currentColor = color;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void _undo() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _strokes.removeLast();
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
    });
  }

  Future<void> _saveImage() async {
    try {
      final imageBytes = await _captureCanvas();
      final blob = html.Blob([imageBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'artwork.png');

      html.document.body?.append(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url);

      anchor.remove();
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<Uint8List> _captureCanvas() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawRect(Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height), Paint()..color = Colors.white);

    for (var stroke in _strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.thickness
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..isAntiAlias = true;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        if (stroke.points[i] != null && stroke.points[i + 1] != null) {
          canvas.drawLine(stroke.points[i]!, stroke.points[i + 1]!, paint);
        }
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(canvasSize.width.toInt(), canvasSize.height.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}

class _Stroke {
  final Color color;
  final double thickness;
  final List<Offset?> points;

  _Stroke({required this.color, required this.thickness, required this.points});
}

class _ArtPainter extends CustomPainter {
  final List<_Stroke> strokes;

  _ArtPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.thickness
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..isAntiAlias = true;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        if (stroke.points[i] != null && stroke.points[i + 1] != null) {
          canvas.drawLine(stroke.points[i]!, stroke.points[i + 1]!, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
