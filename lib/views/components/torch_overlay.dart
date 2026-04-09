import 'package:flutter/material.dart';

class TorchOverlay extends StatelessWidget {
  final String text;

  const TorchOverlay({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TorchClipper(),
      child: Container(
        padding: const EdgeInsets.only(left: 14),
        margin: const EdgeInsets.only(right: 44),
        height: 58,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}

class _TorchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
