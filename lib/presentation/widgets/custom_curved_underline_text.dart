import 'package:flutter/material.dart';
import '../../constant/app_textstyles.dart';

class CustomCurvedUnderline extends StatelessWidget {
  final String title;

  const CustomCurvedUnderline({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    int lastSpaceIndex = title.lastIndexOf(' ');

    if (lastSpaceIndex == -1 || lastSpaceIndex == title.length - 1) {
      return Text(title, style: AppTextStyles.heading());
    }

    String firstPart = title.substring(0, lastSpaceIndex);
    String lastWord = title.substring(lastSpaceIndex + 1);

    TextStyle headingStyle = AppTextStyles.heading();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: headingStyle,
            children: [
              TextSpan(text: firstPart),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 2.0),
                  child: CustomPaint(
                    painter: CurvedUnderlinePainter(),
                    child: Text(
                      lastWord,
                      style: headingStyle.copyWith(
                        color: Colors.orange,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CurvedUnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(size.width, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 10.0,
        0,
        size.height,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
