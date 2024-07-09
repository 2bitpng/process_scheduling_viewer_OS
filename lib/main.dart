import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OS Process Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorPickerPage(),
    );
  }
}

class ColorPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OS Process Viewer'),
        centerTitle: false,
        elevation: 0,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  _Body();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 1500,
        height: 1500,
        child: CustomPaint(
          painter: _SamplePainter(),
        ),
      ),
    );
  }
}

class _SamplePainter extends CustomPainter {
  final List<int> timestamps = [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 1, 0, 2, 1, 0, 2, 1, 0, 2, 1, 0, 2, 1, 0, 1, 0, 1, 0, 1];
  final rectHeight = 200.0;
  final spacing = 20.0;

  void _drawTextWithBackground(Canvas canvas, TextPainter textPainter, String text, Offset offset, double height, Color backgroundColor) {
    // テキストのスタイル
    final textSpan = TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.black,
          fontSize: height,
          ),
        );

    // テキストの計測
    textPainter.text = textSpan;
    textPainter.layout();

    // 背景の描画
    final paint = Paint()..color = backgroundColor;
    canvas.drawRect(
        Rect.fromLTWH(
          offset.dx,
          offset.dy,
          height, // 幅と高さを一致させて正方形にする
          height,
          ),
        paint,
        );

    // テキストの描画
    textPainter.paint(canvas, offset);
  }
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
    final  block_width = (size.width.toInt()-220)~/50;
    // 最初の長方形
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(0, 0, 1500, rectHeight), paint);
    _drawTextWithBackground(canvas, textPainter, "A", Offset(0, 0), rectHeight, Colors.red);

    // 2つ目の長方形
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(0, rectHeight + spacing, 1500, rectHeight), paint);
    _drawTextWithBackground(canvas, textPainter, "B", Offset(0, rectHeight + spacing), rectHeight, Colors.green);

    // 3つ目の長方形
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(0, (rectHeight + spacing) * 2, 1500, rectHeight), paint);
    _drawTextWithBackground(canvas, textPainter, "C", Offset(0, (rectHeight + spacing) * 2), rectHeight, Colors.blue);

    // プロセス A の領域を赤で塗りつぶす
    for (int i = 0; i < timestamps.length; i++) {
      if (timestamps[i] == 0) {
        paint.color = Colors.red;
        canvas.drawRect(Rect.fromLTWH(i * (block_width)+220.toDouble(), 0, block_width.toDouble(),rectHeight), paint);
      }
    }

    // プロセス B の領域を緑で塗りつぶす
    for (int i = 0; i < timestamps.length; i++) {
      if (timestamps[i] == 1) {
        paint.color = Colors.green;
        canvas.drawRect(Rect.fromLTWH(i * (block_width)+220.toDouble(), rectHeight + spacing, block_width.toDouble(), rectHeight), paint);
      }
    }

    // プロセス C の領域を青で塗りつぶす
    for (int i = 0; i < timestamps.length; i++) {
      if (timestamps[i] == 2) {
        paint.color = Colors.blue;
        canvas.drawRect(Rect.fromLTWH(i * (block_width)+220.toDouble(), 2 * (rectHeight + spacing), block_width.toDouble(), rectHeight), paint);
      }
    }

    // 数直線を引く
    _drawNumberLine(canvas, textPainter, Offset(220, 2 * (rectHeight + spacing)), rectHeight, size.width - 220, 50);
  }

  void _drawNumberLine(Canvas canvas, TextPainter textPainter, Offset offset,double height, double width, int divisions) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final double interval = (width.toInt() ~/ divisions).toDouble();
    for (int i = 0; i <= divisions; i++) {
      final x = offset.dx + i * interval;
      canvas.drawLine(Offset(x, offset.dy + height), Offset(x, offset.dy + height - 10), paint);

      // テキストのスタイル
      final textSpan = TextSpan(
        text: '$i',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

      // テキストの計測
      textPainter.text = textSpan;
      textPainter.layout();

      // テキストの描画
      final textOffset = Offset(x - textPainter.width / 2, offset.dy + height + 10);
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
