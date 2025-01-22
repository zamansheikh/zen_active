import 'package:flutter/material.dart';

enum BookingStatus {
  none,
  pastStart,
  past,
  pastEnd,
  runningStart,
  running,
  runningEnd,
  futureStart,
  future,
  futureEnd,
  pastRunning,
  pastFuture,
  runningFuture
}

class CalendarCell extends StatefulWidget {
  final int? dayNumber;
  final bool showBorder;
  final TextStyle? textStyle;
  final BookingStatus status;

  const CalendarCell({
    super.key,
    this.dayNumber,
    this.showBorder = false,
    this.textStyle,
    this.status = BookingStatus.none,
  });

  @override
  State<CalendarCell> createState() => _CalendarCellState();
}

class _CalendarCellState extends State<CalendarCell> {
  final Color _pastBookingColor = Color(0xFF6A6A6A);
  final Color _runningBookingColor = Color(0xFFD80665);
  final Color _futureBookingColor = Color(0xFFFFACA5);

  Color _getColor(BookingStatus status, {isSecondColor = false}) {
    switch (status) {
      case BookingStatus.runningStart:
        return isSecondColor ? _runningBookingColor : Colors.transparent;
      case BookingStatus.running:
        return _runningBookingColor;
      case BookingStatus.runningEnd:
        return isSecondColor ? Colors.transparent : _runningBookingColor;
      case BookingStatus.futureStart:
        return isSecondColor ? _futureBookingColor : Colors.transparent;
      case BookingStatus.future:
        return _futureBookingColor;
      case BookingStatus.futureEnd:
        return isSecondColor ? Colors.transparent : _futureBookingColor;
      case BookingStatus.pastStart:
        return isSecondColor ? _pastBookingColor : Colors.transparent;
      case BookingStatus.past:
        return _pastBookingColor;
      case BookingStatus.pastEnd:
        return isSecondColor ? Colors.transparent : _pastBookingColor;
      case BookingStatus.pastRunning:
        return isSecondColor ? _runningBookingColor : _pastBookingColor;
      case BookingStatus.pastFuture:
        return isSecondColor ? _futureBookingColor : _pastBookingColor;
      case BookingStatus.runningFuture:
        return isSecondColor ? _futureBookingColor : _runningBookingColor;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xffF2F5F7),
        borderRadius: BorderRadius.circular(5),
        border: widget.showBorder
            ? Border.all(color: Colors.black, width: 1)
            : null,
      ),
      child: CustomPaint(
        painter: widget.status != BookingStatus.none
            ? DiagonalSplitPainter(
                topLeftColor: _getColor(widget.status),
                bottomRightColor: _getColor(widget.status, isSecondColor: true),
                status: widget.status,
              )
            : null,
        child: Center(
          child: Text(
            widget.dayNumber != null ? '${widget.dayNumber}' : '',
            style: widget.textStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.status == BookingStatus.none
                      ? Colors.black
                      : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

class DiagonalSplitPainter extends CustomPainter {
  final Color topLeftColor;
  final Color bottomRightColor;
  final BookingStatus status;

  DiagonalSplitPainter({
    required this.topLeftColor,
    required this.bottomRightColor,
    this.status = BookingStatus.none,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw the top-left triangle
    paint.color = topLeftColor;
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(0, size.height)
        ..close(),
      paint,
    );

    // Draw the bottom-right triangle
    paint.color = bottomRightColor;
    canvas.drawPath(
      Path()
        ..moveTo(size.width, size.height)
        ..lineTo(size.width, 0)
        ..lineTo(0, size.height)
        ..close(),
      paint,
    );

    if (status == BookingStatus.runningStart ||
        status == BookingStatus.runningEnd ||
        status == BookingStatus.futureStart ||
        status == BookingStatus.futureEnd ||
        status == BookingStatus.pastStart ||
        status == BookingStatus.pastEnd) {
      //draw a line between the two triangles
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      paint.strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(0 + 1, size.height - 1),
        Offset(size.width - 1, 0 + 1),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
