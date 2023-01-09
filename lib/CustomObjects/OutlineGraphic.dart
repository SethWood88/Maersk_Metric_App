import 'package:flutter/material.dart';
import 'package:metrics_app/utils/constants.dart';

class LeftAveragedReportGraphic extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = MAERSKBLUE
      ..strokeWidth = 15;

    var paint1 = Paint()
      ..color = COLOR_DARK_BLUE
      ..strokeWidth = 15;

    var paint2 = Paint()
      ..color = Colors.orange
      ..strokeWidth = 15;

    var paint3 = Paint()
      ..color = DANGER
      ..strokeWidth = 15;

    var paint4 = Paint()
      ..color = SUCCESS
      ..strokeWidth = 15;

    canvas.drawRect(Rect.fromLTRB(0, 0, 90, 400), paint);
    canvas.drawRect(Rect.fromLTRB(0, 260, 145, 300), paint);

    canvas.drawRect(Rect.fromLTRB(size.width, 0, 300, size.width), paint1);
    canvas.drawRect(Rect.fromLTRB(300, 300, 150, 200), paint1);

    canvas.drawRect(Rect.fromLTRB(200, 0, 255, 100), paint);

    canvas.drawRect(Rect.fromLTRB(260, 0, 295, 100), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class IndividualAPIGraphics extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = LIGHTBLUEGRAPH
      ..strokeWidth = 15;

    var paint1 = Paint()
      ..color = MAERSKBLUE
      ..strokeWidth = 15;

    var paint2 = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 15;

    canvas.drawRect(Rect.fromLTRB(size.width, 300, 300, 125), paint1);
    canvas.drawRect(
        Rect.fromLTRB(0, 247, size.width, size.longestSide), paint1);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, 90), paint);
    canvas.drawRect(Rect.fromLTRB(100, 0, 0, 240), paint);

    canvas.drawRect(Rect.fromLTRB(350, 95, size.width, 120), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class AveragedReportBreakdownGraphic extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = MAERSKBLUE
      ..strokeWidth = 15;

    var paint1 = Paint()
      ..color = COLOR_DARK_BLUE
      ..strokeWidth = 15;

    var paint2 = Paint()
      ..color = Colors.orange
      ..strokeWidth = 15;

    var paint3 = Paint()
      ..color = DANGER
      ..strokeWidth = 15;

    var paint4 = Paint()
      ..color = SUCCESS
      ..strokeWidth = 15;

    canvas.drawRect(Rect.fromLTRB(0, 0, 90, 650), paint);
    canvas.drawRect(Rect.fromLTRB(0, 240, 145, 300), paint);

    canvas.drawRect(Rect.fromLTRB(400, 0, 300, 950), paint1);
    canvas.drawRect(Rect.fromLTRB(300, 300, 150, 200), paint1);
    canvas.drawRect(Rect.fromLTRB(0, 655, 400, 750), paint1);

    canvas.drawRect(Rect.fromLTRB(225, 0, 255, 100), paint);

    canvas.drawRect(Rect.fromLTRB(260, 0, 295, 100), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class MonthBreakdownGraphics extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = LIGHTBLUEGRAPH
      ..strokeWidth = 15;

    var paint1 = Paint()
      ..color = MAERSKBLUE
      ..strokeWidth = 15;

    var paint2 = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 15;

    canvas.drawRect(Rect.fromLTRB(400, 300, 300, 125), paint1);
    canvas.drawRect(
        Rect.fromLTRB(0, 250, size.width, size.longestSide), paint1);

    canvas.drawRect(Rect.fromLTRB(0, 0, 400, 90), paint);
    canvas.drawRect(Rect.fromLTRB(100, 0, 0, 240), paint);

    canvas.drawRect(Rect.fromLTRB(350, 95, 410, 120), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class IndividualBreakdownGraphic extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = MAERSKBLUE
      ..strokeWidth = 15;

    var paint1 = Paint()
      ..color = COLOR_DARK_BLUE
      ..strokeWidth = 15;

    var paint2 = Paint()
      ..color = SUCCESS
      ..strokeWidth = 15;

    var paint3 = Paint()
      ..color = DANGER
      ..strokeWidth = 15;

    var paint4 = Paint()
      ..color = SUCCESS
      ..strokeWidth = 15;

    canvas.drawRect(
        Rect.fromLTRB(0, 0, 90, 590), paint); //LIGHT BLUE LEFT VERTICAL
    canvas.drawRect(Rect.fromLTRB(0, 240, 145, 300), paint); //
    canvas.drawRect(Rect.fromLTRB(225, 0, 255, 100), paint); //LIGHT BLUE SLIVER

    canvas.drawRect(Rect.fromLTRB(size.width, 0, 300, 900), paint1); //LEFT DARK BLUE
    canvas.drawRect(Rect.fromLTRB(300, 300, 150, 200), paint1); //TOP DARK BLUE
    canvas.drawRect(Rect.fromLTRB(0, 690, size.width, 600), paint1); //BOTTOM DARK BLUE

    canvas.drawRect(Rect.fromLTRB(260, 0, 295, 100), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class OutageBreakdownGraphic extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = MAERSKBLUE
      ..strokeWidth = 15;

    var paint1 = Paint()
      ..color = COLOR_DARK_BLUE
      ..strokeWidth = 15;

    var paint2 = Paint()
      ..color = DANGER
      ..strokeWidth = 15;

    // if(DowntimeData.data[colorIndex].p == 'P1'){
    //   var paint2 = Paint()
    //     ..color = DANGER
    //     ..strokeWidth = 15;
    // }else if(DowntimeData.data[colorIndex].p == 'P2'){
    // var paint2 = Paint()
    // ..color = DANGER
    // ..strokeWidth = 15;
    // canvas.drawRect(Rect.fromLTRB(260, 0, 295, 100), paint2);
    // }else {
    //   throw Future.error('P1, P2 error');
    // }

    var paint3 = Paint()
      ..color = DANGER
      ..strokeWidth = 15;

    canvas.drawRect(
        Rect.fromLTRB(0, 0, 90, 590), paint); //LIGHT BLUE LEFT VERTICAL
    canvas.drawRect(Rect.fromLTRB(0, 240, 145, 300), paint); //
    canvas.drawRect(Rect.fromLTRB(225, 0, 255, 100), paint); //LIGHT BLUE SLIVER

    canvas.drawRect(Rect.fromLTRB(size.width, 0, 300, 900), paint1); //LEFT DARK BLUE
    canvas.drawRect(Rect.fromLTRB(300, 300, 150, 200), paint1); //TOP DARK BLUE
    canvas.drawRect(Rect.fromLTRB(0, 690, size.width, 600), paint1); //BOTTOM DARK BLUE

    canvas.drawRect(Rect.fromLTRB(260, 0, 295, 100), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
